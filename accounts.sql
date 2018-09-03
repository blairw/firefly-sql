CREATE OR REPLACE VIEW v_accounts_log AS
SELECT
	tj.id as tj_id,
	tj.date, tj.description,
	REPLACE(jm.data, '\"', '') as internal_reference,
	t.amount as amount,
	t.account_id as account_id,
	a.name as account_name,
	at.type as account_type
FROM
	transactions t 
	JOIN transaction_journals tj ON tj.id = t.transaction_journal_id
	JOIN accounts a ON t.account_id = a.id
	JOIN account_types at ON at.id = a.account_type_id
	LEFT JOIN journal_meta jm ON tj.id = jm.transaction_journal_id AND jm.name = 'internal_reference'
ORDER BY tj.date DESC
;