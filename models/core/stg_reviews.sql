{{ config
    (
        materialized='view'
    ) 
}}

select 
    "review_id" as review_id,
    "listing_id" as listing_id,
    "review_date" as review_date,
    "reviewer_name" as reviewer_name,
    "comments" as comments,
    "sentiment" as sentiment
from {{ source('airbnb', 'reviews') }}