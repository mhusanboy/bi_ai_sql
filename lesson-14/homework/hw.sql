declare @tr nvarchar(max);

with cte as
(
SELECT 
    t.name AS [Table Name],
    i.name AS [Index Name],
    i.type_desc AS [Index Type],
    c.name AS [Column Name]
FROM sys.indexes i
JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
JOIN sys.tables t ON i.object_id = t.object_id
WHERE t.is_ms_shipped = 0
)

    
select @tr = cast(
    (
        select [Table Name] as td, '',
        [Index Name] as td, '',
        [Index Type] as td, '',
        [Column Name] as td
        from cte for xml path('tr')
    ) as nvarchar(max)
)

declare @html_body varchar(max) = '
		<style>
			#indexes {
			  font-family: Arial, Helvetica, sans-serif;
			  border-collapse: collapse;
			  width: 100%;
			}

			#indexes td, #indexes th {
			  border: 1px solid #ddd;
			  padding: 8px;
			}

			#indexes tr:nth-child(even){background-color: #f2f2f2;}

			#indexes tr:hover {background-color: #ddd;}

			#indexes th {
			  padding-top: 12px;
			  padding-bottom: 12px;
			  text-align: left;
			  background-color: #04AA6D;
			  color: white;
			}
			</style>
			</head>
			<body>

			<h1>Indexes table</h1>

			<table id="indexes">
			  <tr>
				<th>Table Name</th>
				<th>Index Name</th>
				<th>Index Type</th>
				<th>Column Name</th>
			  </tr>
			  ' +@tr +
			  '
			</table>
			</body>
'



exec msdb.dbo.sp_send_dbmail
	@profile_name = 'GmailProfile',
	@recipients = 'h.mansuraliyev@newuu.uz;jiyanovagulsora@gmail.com',
	@subject = 'This is metadata about indexes',
	@body = @html_body,
	@body_format = 'HTML'
