{{ config
    (
        materialized='table'
    )
}}

/*
Model: agg_room_type_trends
Description:
    Aggregated metrics at the room_type level.
    Helps track popularity, pricing trends, and review volumes 
    for different room categories.
Grain:
    One row per room_type
*/

select
    room_type,

    -- total number of listings in this room type
    count(distinct listing_id) as total_listings,

    -- average price for listings of this room type
    avg(price) as avg_price,

    -- total number of reviews across listings in this room type
    {{ review_count("review_id") }} as review_count

from {{ fact_with_dims() }}
group by room_type