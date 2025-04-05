Create Database Transactions;
USE transactions;

# 1 Top 5 accounts with the highest transaction amounts:
SELECT AccountID, SUM(TransactionAmount) AS TotalAmount
FROM bank_transaction_csv
GROUP BY AccountID
ORDER BY TotalAmount DESC
LIMIT 5;


# 2. Average transaction amount by transaction type:
SELECT TransactionType, AVG(TransactionAmount) AS AvgAmount
FROM bank_transaction_csv
GROUP BY TransactionType;

#3. Transactions flagged as anomalies (LoginAttempts > 3):
SELECT *
FROM bank_transaction_csv
WHERE LoginAttempts > 3;

#4. Frequency of transactions per account:
SELECT AccountID, COUNT(*) AS TransactionCount
FROM bank_transaction_csv
GROUP BY AccountID
ORDER BY TransactionCount DESC;

# 5. Total balance per location:
SELECT Location, SUM(AccountBalance) AS TotalBalance
FROM bank_transaction_csv
GROUP BY Location
ORDER BY TotalBalance DESC;

#6. Monthly Transaction Trends
SELECT 
    DATE_FORMAT(TransactionDate, '%Y-%m') AS TransactionMonth,
    SUM(TransactionAmount) AS TotalAmount
FROM bank_transaction_csv
GROUP BY TransactionMonth
ORDER BY TransactionMonth;

#7. Most Frequent Merchants
SELECT MerchantID, COUNT(*) AS TransactionCount
FROM bank_transaction_csv
GROUP BY MerchantID
ORDER BY TransactionCount DESC
LIMIT 5;

#8. Transaction Amount Distribution by Age Group
SELECT 
    CASE 
        WHEN CustomerAge BETWEEN 18 AND 25 THEN '18-25'
        WHEN CustomerAge BETWEEN 26 AND 35 THEN '26-35'
        WHEN CustomerAge BETWEEN 36 AND 50 THEN '36-50'
        ELSE '51+'
    END AS AgeGroup,
    AVG(TransactionAmount) AS AvgTransactionAmount,
    COUNT(*) AS TransactionCount
FROM bank_transaction_csv
GROUP BY AgeGroup;

#9. Transaction Volume by Channel and Type
SELECT 
    Channel, 
    TransactionType, 
    COUNT(*) AS TransactionCount,
    SUM(TransactionAmount) AS TotalTransactionAmount
FROM bank_transaction_csv
GROUP BY Channel, TransactionType
ORDER BY TotalTransactionAmount DESC;

#10. Accounts with Large Credit Transactions
SELECT TransactionID, AccountID, TransactionAmount, TransactionDate
FROM bank_transaction_csv
WHERE TransactionType = 'Credit' AND TransactionAmount > 1000
ORDER BY TransactionAmount DESC;


#11. Inactive Accounts
SELECT DISTINCT AccountID
FROM bank_transaction_csv
WHERE DATEDIFF(CURDATE(), STR_TO_DATE(PreviousTransactionDate, '%Y-%m-%d %H:%i:%s')) > 30;

#12. Longest Transactions
SELECT TransactionID, AccountID, TransactionDuration, TransactionAmount, TransactionDate
FROM bank_transaction_csv
ORDER BY TransactionDuration DESC
LIMIT 5;

#13. Login Anomalies by Location
SELECT Location, AVG(LoginAttempts) AS AvgLoginAttempts
FROM bank_transaction_csv
GROUP BY Location
HAVING AvgLoginAttempts > 1.5
ORDER BY AvgLoginAttempts DESC;

#14. Top Locations by Transaction Volume
SELECT Location, COUNT(*) AS TransactionCount
FROM bank_transaction_csv
GROUP BY Location
ORDER BY TransactionCount DESC
LIMIT 10;

#15. Transaction Frequency for Each Account
SELECT 
    AccountID, 
    AVG(TIMESTAMPDIFF(SECOND, STR_TO_DATE(PreviousTransactionDate, '%Y-%m-%d %H:%i:%s'), STR_TO_DATE(TransactionDate, '%Y-%m-%d %H:%i:%s'))) AS AvgTimeGapSeconds
FROM bank_transaction_csv
GROUP BY AccountID
ORDER BY AvgTimeGapSeconds DESC;





