{{ config
    (
        materialized='table'
    )
}}

/*
Model: agg_reviews_by_listing
Description:
    Aggregated view of reviews for each listing.
    Helps analyze property popularity, sentiment, and recency of guest feedback.

Grain:
    One row per listing_id
*/

with reviews_by_listings as
(
    select  
        listing_id,

        -- count reviews for popularity
        count(review_id) as review_count, 

        -- average sentiment score
        avg(sentiment) as avg_sentiment, 

        -- latest review date for recency
        max(review_date) as latest_review_date 

    from {{ ref("fact_reviews") }}
    group by listing_id
)

select *
from reviews_by_listings