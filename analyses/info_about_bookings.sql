{% set aircraft_query %}
select
    distinct
    aircraft_code
from 
    {{ ref('stg_flights__aircrafts') }}
{% endset %}

{% set aircraft_query_result = run_query(aircraft_query)%}

{% if execute %}
    {% set important_aircrafts = aircraft_query_result.columns[0].values() %}
{% else %}
    {% set important_aircrafts = [] %}
{% endif %}


{#{%- set important_aircrafts = ['CN1', 'CR2', '763'] -%}#}

select 
    aircraft_code,
    {%- for aircraft in important_aircrafts %}
    (case when aircraft_code = '{{ aircraft }}' then 1 else 0 end ) as cnt_{{ aircraft }} {% if not loop.last %}, {% endif %}
    {%- endfor %}
from
    {{ ref('stg_flights__aircrafts') }}

{#group by book_ref
having count(*) > 1#}