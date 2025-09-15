{{ config(
        materialized='incremental',
        unique_key='host_id',
        tags=['core', 'dimensions']
) }}

with dim_hosts as (
    select
        "id" as host_id,
        "name" as host_name,
        "is_superhost" as is_superhost,
        "created_at" as created_at,
        "updated_at" as updated_at
    from {{ source('airbnb', 'hosts') }}
)

select * 
from dim_hosts

{% if is_incremental() %}
  -- For incremental loads: only bring in rows updated since last run
  where updated_at > (select max(updated_at) from {{ this }})
{% endif %}
    
