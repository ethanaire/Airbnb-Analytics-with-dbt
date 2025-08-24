{{ config
    (
        materialized='table'
    )
}}

/*
Model: agg_host_performance
Description:
    Host-level performance metrics to evaluate 
    how hosts manage their properties, pricing, and guest feedback.
    Useful for host ranking or quality scoring.
Grain:
    One row per host_id
*/

with host_performance as
(
    select
        host_id,

        -- number of listings per host
        count(distinct listing_id) as listing_count,

        -- total reviews across all listings by this host
        {{ review_count("review_id") }} as review_count,

        -- average price across host's listings
        avg(price) as avg_price_per_listing,

        -- overall average sentiment across host’s listings
        {{ avg_sentiment("sentiment") }} as avg_sentiment,

    from {{ fact_with_dims() }}
    group by host_id
)   

select *
from host_performance