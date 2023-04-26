-- Define a new column "gender_converted"
{{ config(
      materialized='view',
      unique_key='sip'
  ) }}

select
    {{ json_extract_scalar('_airbyte_data', ['sip']) }} as {{ adapter.quote('sip') }},
    {{ json_extract_scalar('_airbyte_data', ['dip']) }} as {{ adapter.quote('dip') }},
    {{ json_extract_scalar('_airbyte_data', ['dmac']) }} as dmac,
    {{ json_extract_scalar('_airbyte_data', ['dport']) }} as dport,
    _airbyte_emitted_at
from {{ source('quarantine', '_airbyte_raw_ods_ndlp_alarmlog') }}