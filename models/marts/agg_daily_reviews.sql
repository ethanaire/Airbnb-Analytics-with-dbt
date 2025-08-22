{{ config
    (
        materialized='table'
    )
}}

/*
Model: agg_daily_reviews
Description:
    Aggregated view of reviews at the day level.
    Helps track platform-wide activity, guest engagement,
    and sentiment trends over time. Useful for time-series dashboards and forecasting.
Grain:
    One row per date_key (FK → dim_date)
*/

with daily_reviews as
(
    select  
        -- date id of any entry
        date_key,

        -- number of reviews on that date
        count(review_id) as review_count,

        -- number of distinct listings that received reviews. 
        count(distinct listing_id) as unique_listing_count,

        -- number of distinct hosts that received reviews.
        count(distinct host_id) as unique_host_count,

        -- average sentiment score across reviews on that day
        avg(sentiment) as avg_sentiment

    from {{ ref("fact_reviews") }}
    group by date_key
)

select *
from daily_reviews