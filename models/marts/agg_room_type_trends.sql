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
        listing_id,
        count(review_id) as review_count, -- count reviews for popularity
        avg(sentiment) as avg_sentiment, -- average sentiment score
        MAX(review_date) as latest_review_date -- latest review date for recency
    from {{ ref("fact_reviews") }}
    group by host_id
)

select *
from host_performance