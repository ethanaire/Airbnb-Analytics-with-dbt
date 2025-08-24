{{ config(
    materialized='incremental',
    unique_key='review_id'
) }}

with fact_reviews as (
    select
        fr.review_id,
        fr.listing_id,
        dl.host_id,                
        fr.review_date,
        fr.reviewer_name,
        fr.sentiment, 
        dd."date_id" as date_key
    from {{ ref('stg_reviews') }} fr
    left join {{ ref('dim_listing') }} dl 
        on fr.listing_id = dl.listing_id
    left join {{ ref('dim_date') }} dd
        on fr.review_date = dd."date"
)

select * 
from fact_reviews

{% if is_incremental() %}
  -- Incremental filter: Only new reviews 
  where review_id > (select max(review_id) from {{ this }})
{% endif %}
