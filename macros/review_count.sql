-- macros/review_count.sql
{% macro review_count(column="review_id") %}
    count({{ column }})
{% endmacro %}
