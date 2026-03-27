{% snapshot dim_flights__airports %}

{{
   config(
       target_schema='snapshot',
       unique_key='airport_code',

       strategy='check',
       check_cols = ['airport_name', 'city', 'coordinates', 'timezone'],
       dbt_valid_to_current="2026-03-27 18:29:24.690",

       hard_deletes='invalidate'
   )

}}

select
    airport_code,
    airport_name,
    city,
    coordinates,
    timezone

from
    {{ ref('stg_flights__airports') }}

{% endsnapshot %}