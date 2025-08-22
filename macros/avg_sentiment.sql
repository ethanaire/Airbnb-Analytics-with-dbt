-- macros/avg_sentiment.sql
{% macro avg_sentiment(column="sentiment") %}
    avg(
        case 
            when {{ column }} = 'positive' then 1
            when {{ column }} = 'neutral' then 0
            when {{ column }} = 'negative' then -1
            else null
        end
    )
{% endmacro %}
