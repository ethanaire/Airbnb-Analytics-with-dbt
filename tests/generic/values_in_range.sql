{% macro values_in_range(model, column_name, min_value, max_value) %}

select
    {{ column_name }} as value
from {{ model }}
where
    {{ column_name }} < {{ min_value }}
    and {{ column_name }} > {{ max_value }} -- compare values between min_value and max_value

{% endmacro %}