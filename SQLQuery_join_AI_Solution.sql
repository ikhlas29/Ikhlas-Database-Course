Create database AI_solution

Use AI_solution

-- Table 1: Servers 
Create table Servers ( 
    server_id int primary key, 
    server_name varchar(50), 
    region varchar(50) 
)


-- Table 2: Alerts 
Create table Alerts ( 
    alert_id int primary key, 
    server_id int, 
    alert_type varchar(50), 
    severity varchar(20) 
)


-- Table 3: AI Models 
Create table AI_Models ( 
    model_id int primary key, 
    model_name varchar(50), 
    use_case varchar(50) 
)


-- Table 4: ModelDeployments 
Create table ModelDeployments ( 
    deployment_id int primary key, 
    server_id int, 
    model_id int, 
    deployed_on date 
)


----- Data insert ----
-- Servers --
Insert into Servers values 
(1, 'web-server-01', 'us-east'), 
(2, 'db-server-01', 'us-east'), 
(3, 'api-server-01', 'eu-west'), 
(4, 'cache-server-01', 'us-west')
 
 -- Alerts --
Insert into Alerts values 
(101, 1, 'CPU Spike', 'High'), 
(102, 2, 'Disk Failure', 'Critical'), 
(103, 2, 'Memory Leak', 'Medium'), 
(104, 5, 'Network Latency', 'Low') -- Invalid server_id (edge case)

 -- AI_Models --
Insert into AI_Models values 
(201, 'AnomalyDetector-v2', 'Alert Prediction'), 
(202, 'ResourceForecaster', 'Capacity Planning'), 
(203, 'LogParser-NLP', 'Log Analysis')

-- ModelDeployments --
Insert into ModelDeployments values 
(301, 1, 201, '2025-06-01'), 
(302, 2, 201, '2025-06-03'), 
(303, 2, 202, '2025-06-10'), 
(304, 3, 203, '2025-06-12')


--Task 1: INNER JOIN 
--List all alerts with the corresponding server name. 

Select alert_id, server_name
From Alerts Alt ,Servers Srv
Where Alt.server_id = Srv.server_id
------------------------------------------------------------

--Task 2: LEFT JOIN 
--List all servers and any alerts they might have received.
Select server_name, alert_id
From Servers Srv , Alerts Alt
Where Alt.server_id = Srv.server_id
---------------------------------------------------------

--Task 3: RIGHT JOIN 
--Show all alerts and the server name that triggered them, including alerts without a matching server.
Select alert_id, server_name
From Servers Srv , Alerts Alt
Where Alt.server_id = Srv.server_id
-----------------------------------------------------------

--Task 4: FULL OUTER JOIN 
--List all servers and alerts, including unmatched ones on both sides. 
Select alert_id, server_name
From Servers Srv full outer join Alerts Alt
On Alt.server_id = Srv.server_id
------------------------------------------------------------

--Task 5: CROSS JOIN 
--Pair every AI model with every server (e.g., simulation of possible deployments).
-- Solution as naming --
Select model_name , server_name
From AI_Models , Servers

-- Solution as id--
Select model_id , server_id
From AI_Models , Servers
--------------------------------------------------------

--Task 6: INNER JOIN with Filter 
--List all critical alerts with the server name.
Select alert_type, server_name
From Alerts Alt , Servers Srv
Where Alt.server_id = Srv.server_id and Alt.severity = 'Critical'
-------------------------------------------------------------

--Task 7: LEFT JOIN with NULL filter 
--Find servers that do not have any AI models deployed.
Select Srv.server_id , MD.model_id
From Servers Srv left join ModelDeployments MD
On Srv.server_id = MD.server_id 
Where MD.deployment_id is null 
----------------------------------------------------------
Select * from Servers
--Task 8: CROSS JOIN with WHERE 
--Simulate possible deployments for EU region servers only. 
Select deployment_id , region , model_id
From ModelDeployments MD , Servers Srv
Where Srv.region = 'eu-west'



