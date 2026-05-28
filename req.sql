Nombre de tri par jour
SELECT
    AVG(daily_count) AS avg_orders_per_day
FROM (
    SELECT
        DATE(created_at) AS day,
        COUNT(*) AS daily_count
    FROM orders
    WHERE created_at >= '2025-01-01'
      AND created_at < '2026-01-01'
    GROUP BY DATE(created_at)
) AS daily_orders;

-- Par site
-- SELECT
--     site_id,
--     AVG(daily_count) AS avg_orders_per_day
-- FROM (
--     SELECT
--         site_id,
--         DATE(sorting_start_at) AS day,
--         COUNT(*) AS daily_count
--     FROM orders
--     WHERE sorting_start_at >= '2025-01-01'
--       AND sorting_start_at < '2026-01-01'
--     GROUP BY site_id, DATE(sorting_start_at)
-- ) AS daily_orders
-- GROUP BY site_id
-- ORDER BY site_id;

Nombre moyen de event par jour

SELECT
    pes.event_type,
    et.description AS event_label,
    ROUND(COUNT(*) / COUNT(DISTINCT pes.order_id), 2) AS avg_per_order
FROM production_event_summaries pes
LEFT JOIN event_types et ON et.id = pes.event_type
WHERE pes.event_datetime >= '2025-01-01'
  AND pes.event_datetime < '2026-01-01'
GROUP BY pes.event_type, et.description
ORDER BY avg_per_order DESC;
