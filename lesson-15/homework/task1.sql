
-- ddl process

DROP TABLE IF EXISTS Contacts;
CREATE TABLE Contacts
(
	identifier_name NVARCHAR(50),
	identifier_value NVARCHAR(255),
	firstname NVARCHAR(255),
	lastname NVARCHAR(255),
	website NVARCHAR(255),
	company NVARCHAR(255),
	phone NVARCHAR(255),
	address NVARCHAR(255),
	city NVARCHAR(255),
	state NVARCHAR(255),
	zip NVARCHAR(255),
);

INSERT INTO Contacts(identifier_name, identifier_value, firstname, lastname, website, company, phone, address, city, state, zip)
VALUES 
	('vid', '259429', 'Harper', 'Wolfberg', 'http://hubspot.com', 'HubSpot', '555-122-2323', '25 First Street', 'Cambridge', 'MA', '02139'),
	('email', 'testingapis@hubspot.com', 'Codey', 'Huang', 'http://hubspot.com', 'HubSpot', '555-122-2323', '25 First Street', 'Cambridge', 'MA', '02139'),
    ('email', 'john.doe@example.com', 'John', 'Doe', 'http://example.org', 'Example Inc', '555-345-6789', '456 Oak St', 'Boston', 'MA', '02110'),
    ('email', 'alice.wonderland@fable.com', 'Alice', 'Wonderland', 'http://fable.com', 'Fable Enterprises', '555-987-6543', '102 Rabbit Hole', 'Wonderland', 'CA', '90210'),
	('vid', '543210', 'Ava', 'Smith', 'http://example.com', 'Example Corp', '555-233-4545', '123 Maple Ave', 'Springfield', 'IL', '62701'),
    ('vid', '987654', 'Jane', 'Roe', 'http://company.net', 'Company LLC', '555-678-1234', '789 Pine Rd', 'New York', 'NY', '10001'),
    ('email', 'emily.brown@company.com', 'Emily', 'Brown', 'http://company.com', 'Company Ltd', '555-222-3333', '88 Blueberry Lane', 'Austin', 'TX', '73301'),
    ('vid', '321987', 'Robert', 'Johnson', 'http://robertj.com', 'RJ Consulting', '555-111-2222', '22 Lincoln Way', 'Columbus', 'OH', '43215'),
    ('vid', '654321', 'Michael', 'Davis', 'http://davistech.com', 'Davis Technologies', '555-444-5555', '99 Tech Park', 'Seattle', 'WA', '98109'),
    ('email', 'oliver.queen@starcity.com', 'Oliver', 'Queen', 'http://starcity.com', 'Star City Industries', '555-777-8888', '567 Arrow St', 'Star City', 'CA', '94016');


-- task


declare @column_names NVARCHAR(MAX);


SELECT @column_names = String_agg(COLUMN_NAME, ',')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Contacts' and COLUMN_NAME not IN ('identifier_name', 'identifier_value');

declare @query NVARCHAR(MAX);

set @query = concat(
        'SELECT identifier_name, identifier_value, col, val
        FROM Contacts 
        UNPIVOT (val FOR col IN (', @column_names, ')) AS unpvt'
);

declare @table table(
    identifier_name nvarchar(127), identifier_value nvarchar(127), col nvarchar(127), val NVARCHAR(127)
);

insert into @table 
exec(@query);

declare @ans nvarchar(max);
set @ans = '[';

select @ans = concat(@ans, '{"', identifier_name, '":"', identifier_value, '",
                            "properties" : [', STRING_AGG('{"property": "' + col + '","value":"' + val + '"}', ','), ']},')
from @table
group by identifier_name, identifier_value


if RIGHT(@ans, 1) = ','
begin
    set @ans = LEFT(@ans, len(@ans) - 1);
end 
set @ans = @ans + ']';


select @ans;