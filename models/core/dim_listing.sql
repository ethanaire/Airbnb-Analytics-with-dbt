{{ config(
        materialized='incremental',
        unique_key='listing_id',
        tags=['core', 'dimensions']
) }}

with dim_listing as (
    select
        "id" as listing_id,
        trim("name") as listing_name,
        "room_type" as room_type,
        "minimum_nights" as minimum_nights,
        "price" as price,
        "host_id" as host_id,
        -- Extract the third part of a listing url separated by '/'
        split_part(listing_url, '/', 3) as listing_url       
    from {{ source('airbnb', 'listings') }}
)

select * 
from dim_listing

{% if is_incremental() %}
  -- Incremental filter: only new rows (avoid duplicates by PK)
  where listing_id not in (select listing_id from {{ this }})
{% endif %}
