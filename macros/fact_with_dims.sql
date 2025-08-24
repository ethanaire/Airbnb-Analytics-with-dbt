-- one-stop macro for joining fact with 2 dims table for reusable logic on aggregate models

{% macro fact_with_dims() %}
    (
        select
            fr.*,
            dl.listing_name,
            dl.room_type,
            dl.minimum_nights,
            dl.price,
            dh.host_name,
            dh.is_superhost
        from {{ ref('fact_reviews') }} fr
        -- Join listing dimension
        left join {{ ref('dim_listing') }} dl
            on fr.listing_id = dl.listing_id
        -- Join host dimension
        left join {{ ref('dim_host') }} dh
            on fr.host_id = dh.host_id
    )
{% endmacro %}
