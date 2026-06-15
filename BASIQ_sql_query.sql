/*Practice Questions*/

# 1. Find customers who are Male AND Married.
# Hint: Use AND to combine two categorical conditions.
select custID, Gender, Married
From `loan_db.customer`
where Gender='Male' and Married=TRUE;

# 2. Find customers whose income is greater than 6000 AND credit history = 1.
# Hint: Combine numeric + logical filtering.
select custID, ApplicantIncome ,Credit_History
From `loan_db.customer`
where ApplicantIncome>6000 and Credit_History=1;
# 3. Find customers who are NOT Graduate OR Self Employed.
# Hint: Think how OR expands the result set.
select custID, Education ,Self_Employed
From `loan_db.customer`
where Education='Not Graduated' or Self_Employed=FALSE;

# 4. Find customers who are from Urban area AND (Married OR Credit_History = 1).
# Hint: Use brackets to control logic.
select custID,Married  ,Credit_History,Property_Area
From `loan_db.customer`
where Property_Area='Urban'and (Married=TRUE or Credit_History=1);

# 5. Find customers whose income is less than 3000 OR (CoapplicantIncome > 2000 AND Married = 'Yes').
# Hint: Nested logic — SQL evaluates brackets first, then outer condition.
select custID,Married  ,ApplicantIncome, CoapplicantIncome
From `loan_db.customer`
where ApplicantIncome<3000 or(CoapplicantIncome>2000 and Married=TRUE);