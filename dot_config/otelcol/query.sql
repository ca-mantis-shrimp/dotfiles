-- Load with: duckdb -init ~/.config/otelcol/query.sql
-- Then query, for example:
--   SELECT observed_at, service_name, severity, body FROM agent_logs ORDER BY observed_at DESC LIMIT 50;
--   SELECT service_name, scope_name, metric_name, metric FROM pi_metrics;
CREATE OR REPLACE VIEW agent_log_exports AS
SELECT *
FROM read_ndjson_auto(
  getenv('HOME') || '/.local/state/otelcol/agent-logs*.jsonl',
  filename = true,
  union_by_name = true
);

CREATE OR REPLACE VIEW agent_logs AS
SELECT
  filename,
  make_timestamp_ns(CAST(log_record.timeUnixNano AS BIGINT)) AS observed_at,
  list_extract(
    list_transform(
      list_filter(resource_log.resource.attributes, lambda attribute: attribute.key = 'service.name'),
      lambda attribute: attribute.value.stringValue
    ),
    1
  ) AS service_name,
  list_extract(
    list_transform(
      list_filter(resource_log.resource.attributes, lambda attribute: attribute.key = 'host.name'),
      lambda attribute: attribute.value.stringValue
    ),
    1
  ) AS host_name,
  scope_log.scope.name AS scope_name,
  log_record.severityText AS severity,
  log_record.body.stringValue AS body,
  resource_log.resource.attributes AS resource_attributes
FROM agent_log_exports,
  unnest(resourceLogs) AS resource_logs(resource_log),
  unnest(resource_log.scopeLogs) AS scope_logs(scope_log),
  unnest(scope_log.logRecords) AS log_records(log_record);

CREATE OR REPLACE VIEW agent_metric_exports AS
SELECT *
FROM read_ndjson_auto(
  getenv('HOME') || '/.local/state/otelcol/agent-metrics*.jsonl',
  filename = true,
  union_by_name = true
);

CREATE OR REPLACE VIEW pi_metrics AS
SELECT
  filename,
  list_extract(
    list_transform(
      list_filter(resource_metric.resource.attributes, lambda attribute: attribute.key = 'service.name'),
      lambda attribute: attribute.value.stringValue
    ),
    1
  ) AS service_name,
  list_extract(
    list_transform(
      list_filter(resource_metric.resource.attributes, lambda attribute: attribute.key = 'host.name'),
      lambda attribute: attribute.value.stringValue
    ),
    1
  ) AS host_name,
  scope_metric.scope.name AS scope_name,
  metric.name AS metric_name,
  metric
FROM agent_metric_exports,
  unnest(resourceMetrics) AS resource_metrics(resource_metric),
  unnest(resource_metric.scopeMetrics) AS scope_metrics(scope_metric),
  unnest(scope_metric.metrics) AS metrics(metric);
