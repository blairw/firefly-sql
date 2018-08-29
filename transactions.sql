SELECT
	tj.id as tj_id,
	tj.date, tj.description,
	jm.data,
	t1.amount as t1_amount,
	t1.account_id as t1_account_id,
	a1.name as t1_account_name,
	t2.account_id as t2_account_id,
	a2.name as t2_account_name
FROM
	transaction_journals tj
	LEFT JOIN journal_meta jm ON tj.id = jm.transaction_journal_id AND jm.name = 'internal_reference',
	transactions t1,
	transactions t2,
	accounts a1,
	accounts a2
WHERE
	(t1.account_id = a1.id) AND (t2.account_id = a2.id)
	AND
	(t1.transaction_journal_id = tj.id AND t1.amount > 0)
	AND
	(t2.transaction_journal_id = tj.id AND t2.amount < 0)
ORDER BY tj.date DESC
;