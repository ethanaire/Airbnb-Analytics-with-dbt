{% test no_future_dates(model, column_name) %}
    select *
    from {{ model }}
    -- ensure the selected date is not in the future
    where cast({{ column_name }} as date) >= current_date + 1 
{% endtest %}