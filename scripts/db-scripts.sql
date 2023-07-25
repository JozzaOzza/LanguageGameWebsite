/*
Make table
*/
CREATE TABLE table_name (
    id int IDENTITY(1,1) PRIMARY KEY,
    english varchar(255) NOT NULL,
    italian varchar(255) NOT NULL,
    category varchar(255) NOT NULL,
    alternatives varchar(255) NOT NULL,
    examplePhrase varchar(255) NOT NULL
);

/*
Add column 
*/
ALTER TABLE table_name
ADD column_name datatype;

/*
Add row(s)
*/
INSERT INTO [dbo].[nouns]
VALUES ('popularity', 'popolarità', 'society', 'gradimento', '')

/*
Update rows
*/
UPDATE [dbo].[nouns]
SET english = 'time (general)', italian = 'tempo', alternatives = ''
WHERE id = 50;

/*
Update column
*/
UPDATE [dbo].[nouns]
SET category = 'time'
WHERE category = 'time (specific)';