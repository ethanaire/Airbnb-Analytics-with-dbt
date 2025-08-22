{{ config
    (
        materialized='table'
    )
}}

/*
Model: agg_host_performance
Description:
    Host-level performance metrics to evaluate how hosts manage their properties, pricing, and guest feedback.
    Useful for host ranking or quality scoring.
Grain:
    One row per host_id
*/

with host_performance as
(
    select
        l.host_id,

        -- number of listings per host
        count(distinct l.listing_id) as listing_count,

        -- total reviews across all listings by this host
        count(distinct r.review_id) as review_count,

        -- average price across host's listings
        avg(l.price) as avg_price_per_listing,

        -- overall average sentiment across host’s listings
        avg(r.sentiment) as avg_sentiment

    from {{ ref("dim_listing") }} l
    left join {{ ref("fact_reviews") }} r
        on l.listing_id = r.listing_id
    group by l.host_id
)

select *
from host_performance