# Assignment 1: Design a Logical Model
Name: Zhiyang Wei

## Question 1
Create a logical model for a small bookstore. 📚

At the minimum it should have employee, order, sales, customer, and book entities (tables). Determine sensible column and table design based on what you know about these concepts. Keep it simple, but work out sensible relationships to keep tables reasonably sized. Include a date table. There are several tools online you can use, I'd recommend [_Draw.io_](https://www.drawio.com/) or [_LucidChart_](https://www.lucidchart.com/pages/).
![image](/Users/Zhiyang/DSI/sql/02_assignments/Q1.drawio-3.png)


## Question 2
We want to create employee shifts, splitting up the day into morning and evening. Add this to the ERD.
![image](/Users/Zhiyang/DSI/sql/02_assignments/Q2.drawio.png)

## Question 3
The store wants to keep customer addresses. Propose two architectures for the CUSTOMER_ADDRESS table, one that will retain changes, and another that will overwrite. Which is type 1, which is type 2?

_Hint, search type 1 vs type 2 slowly changing dimensions._

Bonus: Are there privacy implications to this, why or why not?
```
Your answer...
In a Type 1 table, changes to customer addresses will overwrite the existing data. This approach does not retain historical information about previous addresses, it saves the storage, but we would lost some records.
In a Type 2 table, changes to customer addresses are tracked by creating a new record for each change. This approach retains historical information about previous addresses, I would add a time column for Type2 in order to track. Type 2 is more complex and requires more storage, but maybe helpful if we would like to do more deep analysis about the customers.
![image](/Users/Zhiyang/DSI/sql/02_assignments/Type1.drawio.png)
![image](/Users/Zhiyang/DSI/sql/02_assignments/Type2.drawio.png)

Yes, there are privacy implications to consider when implementing both Type 1 and Type 2 architectures.
Comparin to Type 2, Type 1 doesn't retain historical addresses, the exposure of personal information is less risky. Also, we should realize that retaining old addresses may not be necessary unless there is a clear, justified need for it.
But for both methods, we should follow the ethics and data protection regulations (data is protected under HIPAA (PHIPA in Canada)), store and use data in securely ways.

```

## Question 4
Review the AdventureWorks Schema [here](https://i.stack.imgur.com/LMu4W.gif)

Highlight at least two differences between it and your ERD. Would you change anything in yours?
```
Your answer...
Yes there are many differences between it and mine. I realized that I missed some details about sales and orders.
![image](/Users/Zhiyang/DSI/sql/02_assignments/LMu4W-2.pdf)
I don't have product-inventory table to track the inventory, also maybe the purchasing and vendor tables are useful. For sales order and purchasing order, I didn't calculate tax.
For the order-detail table, the AdventureWorks Schema use both order_id and order_detail_id as keys, but I use the combination of order_id and book_id as unique keys.
I realized that all tables of the AdventureWorks Schema has a variable "modified_date", as Thomas mentioned in class, it's very useful and necessary to track records.
I would update my ERD as below, but still leave the "modified_date" as optional to simplify.
![image](/Users/Zhiyang/DSI/sql/02_assignments/Q4.drawio.png)
```

# Criteria

[Assignment Rubric](./assignment_rubric.md)

# Submission Information

🚨 **Please review our [Assignment Submission Guide](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md)** 🚨 for detailed instructions on how to format, branch, and submit your work. Following these guidelines is crucial for your submissions to be evaluated correctly.

### Submission Parameters:
* Submission Due Date: `June 1, 2024`
* The branch name for your repo should be: `model-design`
* What to submit for this assignment:
    * This markdown (design_a_logical_model.md) should be populated.
    * Two Entity-Relationship Diagrams (preferably in a pdf, jpeg, png format).
* What the pull request link should look like for this assignment: `https://github.com/<your_github_username>/sql/pull/<pr_id>`
    * Open a private window in your browser. Copy and paste the link to your pull request into the address bar. Make sure you can see your pull request properly. This helps the technical facilitator and learning support staff review your submission easily.

Checklist:
- [ 1] Create a branch called `model-design`.
- [ 1] Ensure that the repository is public.
- [ 1] Review [the PR description guidelines](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md#guidelines-for-pull-request-descriptions) and adhere to them.
- [ ] Verify that the link is accessible in a private browser window.

If you encounter any difficulties or have questions, please don't hesitate to reach out to our team via our Slack at `#cohort-3-help`. Our Technical Facilitators and Learning Support staff are here to help you navigate any challenges.
