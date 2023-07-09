/*
Make table
*/
CREATE TABLE nouns (
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
INSERT INTO table_name (column_list)
VALUES
    (value_list_1),
    (value_list_2)