	--0. getting a preview of the content structure
--select top 3 * from wolf

     --1a. Remove local identifiers from nation
--update wolf
--set Location = reverse(location);

--select 
--rtrim(location,CHARINDEX(' ,', reverse(location))) AS location
--FROM wolf

--delete from wolf
--where location is null 

--update wolf
--set Location = right(location,CHARINDEX(' ,', reverse(location)))
--update wolf set location =
--rtrim(location,charindex(' ,', reverse(location)))

     --1b. rectifying error where some . were left in
			--1b. Note: some nations are former nations or have changed, so those are left as is (ex: Karela(formerly finland))
--update wolf
--set Location = LEFT(location,CHARINDEX('.',location +'.')-1)

     --1c. grouping nations for count
select location, count(location) as count from wolf
group by location;

	--2a.  get seperation of attack types
with CTE_attack as (select Type_of_attack as 'Attack', count(type_of_attack) as 'Count' from wolf group by type_of_attack),
CTE_attack2 as (select count, Case 
	when attack = 'Rabid' then 'Rabid'
	when attack = 'Predatory' then 'Predatory'
	else 'Other'
	end as 'Attack_Type'
		from CTE_attack) 
	select Attack_Type, sum(Count) as count
	from CTE_attack2
	group by Attack_Type;

	--3a. get over time attacks
	with CTE_year as (select trim(date) as year from wolf group by date),
	CTE_year2 as (select right(trim(year),5) as year from CTE_year  group by year),
	CTE_year3 as (select year as year, count(year) as number from CTE_year2 group by year)
	select *  from CTE_year3 order by year asc;