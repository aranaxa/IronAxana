# Connecting SQL with Python

## Table of Content

### Day 1:  [SQL_to_Python_Connection.ipynb](https://github.com/aranaxa/IronAxana/blob/main/Week_4/Beautiful_Repo_and_Readme/SQL_to_Python_Connection.ipynb)

1. Connecting to MySQL from Python
2. Initial query on loans to check everything works
3. Aggregated query to select summary rows of loans
4. Visualization
5. Can we do a churn analysis without a complex SQL query?

### Day 2: [Logistic_Regression_Bank.ipynb](https://github.com/aranaxa/IronAxana/blob/main/Week_4/Beautiful_Repo_and_Readme/Logistic_Regression_Bank.ipynb)

1. Binary Classification with Logistic Regression
	* Import libraries
	* Connection to SQL
	* EDA - exploratory data analysis - get to know the data
	* Histograms or boxplots
	* Check for multicollinearity
	* Cleaning and wrangling steps
	* Pre-processing
	* Split off the dependent variable (label)
	* Train test split, get logistic regression model
2.  Apply model and train model
	* Evaluate accuracy and test
	* Visualizing accuracy - ROC / AUC
	* Visualizing accuracy - confusion matrix
	* Data is highly imbalanced (not complete yet)


### Business Challenge:

Using logistic regression, can we predict whether a loan ends up as 
* Status A (contract finished, no problems) OR
* Status B (contract finished, loan not payed)?

### Process:
* **SQL:** Set up SQL query
* **EDA:** Assessed dataframe to prepare for cleaning
* **Data cleaning & wrangling in Python:** Dropped columns 'loan_id' and 'type'
* **Pre-processing:** 
	- Converted column 'status' into dummy variables
	- Scaled numerical columns to be normalized (Gaussian distribution)
* **Machine-learning model:** Logistic regression using scikit-learn
* **Visualizations:**
	- ROC curve
	- Confusion matrix

### Outcome:
* AUC is 0.78, meaning there is a 78% chance that the model will be able to distinguish between status A and status B
* Confusion matrix:
	- # 63 are not status B - true positive
	- 0 are not status B - false positive
	- 8 are status B - false negative
	- 0 are status B - true negative

### Conclusion:
The model fails to predict status B because the dataset is too small. Further steps will need to be taken to improve the results.




