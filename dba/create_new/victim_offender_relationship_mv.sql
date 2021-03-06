CREATE MATERIALIZED VIEW nibrs_national_denorm_victim_offender_relationship AS
select
offense_name as offense_name,
data_year as data_year,
coalesce(sum(case when relationship = 'Victim Was Acquaintance' then count end), 0) as acquaintance,
coalesce(sum(case when relationship = 'Victim Was Babysittee' then count end), 0) as babysittee,
coalesce(sum(case when relationship = 'Victim Was Boyfriend/Girlfriend' then count end), 0) as boyfriend_girlfriend,
coalesce(sum(case when relationship = 'Victim Was Child of Boyfriend or Girlfriend' then count end), 0) as child_boyfriend_girlfriend,
coalesce(sum(case when relationship = 'Victim Was Child' then count end), 0) as child,
coalesce(sum(case when relationship = 'Victim Was Common-Law Spouse' then count end), 0) as common_law_spouse,
coalesce(sum(case when relationship = 'Victim was Employee' then count end), 0) as employee,
coalesce(sum(case when relationship = 'Victim was Employer' then count end), 0) as employer,
coalesce(sum(case when relationship = 'Victim Was Friend' then count end), 0) as friend,
coalesce(sum(case when relationship = 'Victim Was Grandchild' then count end), 0) as grandchild,
coalesce(sum(case when relationship = 'Victim Was Grandparent' then count end), 0) as grandparent,
coalesce(sum(case when relationship = 'Homosexual Relationship' then count end), 0) as homosexual_relationship,
coalesce(sum(case when relationship = 'Victim Was In-law' then count end), 0) as in_law,
coalesce(sum(case when relationship = 'Victim Was Neighbor' then count end), 0) as neighbor,
coalesce(sum(case when relationship = 'Victim Was Other Family Member' then count end), 0) as other_family_member,
coalesce(sum(case when relationship = 'Victim was Otherwise Known' then count end), 0) as otherwise_known,
coalesce(sum(case when relationship = 'Victim Was Parent' then count end), 0) as parent,
coalesce(sum(case when relationship = 'Relationship Unknown' then count end), 0) as relationship_unknown,
coalesce(sum(case when relationship = 'Victim Was Sibling' then count end), 0) as sibling,
coalesce(sum(case when relationship = 'Victim Was Stepchild' then count end), 0) as stepchild,
coalesce(sum(case when relationship = 'Victim Was Spouse' then count end), 0) as spouse,
coalesce(sum(case when relationship = 'Victim Was Stepparent' then count end), 0) as stepparent,
coalesce(sum(case when relationship = 'Victim Was Stepsibling' then count end), 0) as stepsibling,
coalesce(sum(case when relationship = 'Victim Was Stranger' then count end), 0) as stranger,
coalesce(sum(case when relationship = 'Victim Was Offender' then count end), 0) as offender,
coalesce(sum(case when relationship = 'Victim was Ex-Spouse' then count end), 0) as ex_spouse
from public.nibrs_victim_to_offender_relationship_count group by offense_name, data_year;


CREATE MATERIALIZED VIEW nibrs_state_denorm_victim_offender_relationship AS
select  state_id as state_id,
state_abbr as state_abbr,
offense_name as offense_name,
data_year as data_year,
coalesce(sum(case when relationship = 'Victim Was Acquaintance' then count end), 0) as acquaintance,
coalesce(sum(case when relationship = 'Victim Was Babysittee' then count end), 0) as babysittee,
coalesce(sum(case when relationship = 'Victim Was Boyfriend/Girlfriend' then count end), 0) as boyfriend_girlfriend,
coalesce(sum(case when relationship = 'Victim Was Child of Boyfriend or Girlfriend' then count end), 0) as child_boyfriend_girlfriend,
coalesce(sum(case when relationship = 'Victim Was Child' then count end), 0) as child,
coalesce(sum(case when relationship = 'Victim Was Common-Law Spouse' then count end), 0) as common_law_spouse,
coalesce(sum(case when relationship = 'Victim was Employee' then count end), 0) as employee,
coalesce(sum(case when relationship = 'Victim was Employer' then count end), 0) as employer,
coalesce(sum(case when relationship = 'Victim Was Friend' then count end), 0) as friend,
coalesce(sum(case when relationship = 'Victim Was Grandchild' then count end), 0) as grandchild,
coalesce(sum(case when relationship = 'Victim Was Grandparent' then count end), 0) as grandparent,
coalesce(sum(case when relationship = 'Homosexual Relationship' then count end), 0) as homosexual_relationship,
coalesce(sum(case when relationship = 'Victim Was In-law' then count end), 0) as in_law,
coalesce(sum(case when relationship = 'Victim Was Neighbor' then count end), 0) as neighbor,
coalesce(sum(case when relationship = 'Victim Was Other Family Member' then count end), 0) as other_family_member,
coalesce(sum(case when relationship = 'Victim was Otherwise Known' then count end), 0) as otherwise_known,
coalesce(sum(case when relationship = 'Victim Was Parent' then count end), 0) as parent,
coalesce(sum(case when relationship = 'Relationship Unknown' then count end), 0) as relationship_unknown,
coalesce(sum(case when relationship = 'Victim Was Sibling' then count end), 0) as sibling,
coalesce(sum(case when relationship = 'Victim Was Stepchild' then count end), 0) as stepchild,
coalesce(sum(case when relationship = 'Victim Was Spouse' then count end), 0) as spouse,
coalesce(sum(case when relationship = 'Victim Was Stepparent' then count end), 0) as stepparent,
coalesce(sum(case when relationship = 'Victim Was Stepsibling' then count end), 0) as stepsibling,
coalesce(sum(case when relationship = 'Victim Was Stranger' then count end), 0) as stranger,
coalesce(sum(case when relationship = 'Victim Was Offender' then count end), 0) as offender,
coalesce(sum(case when relationship = 'Victim was Ex-Spouse' then count end), 0) as ex_spouse
from public.nibrs_victim_to_offender_relationship_count group by state_id, state_abbr, offense_name, data_year;

CREATE MATERIALIZED VIEW nibrs_agency_denorm_victim_offender_relationship AS
select  agency_id as agency_id,
ori as ori,
offense_name as offense_name,
data_year as data_year,
coalesce(sum(case when relationship = 'Victim Was Acquaintance' then count end), 0) as acquaintance,
coalesce(sum(case when relationship = 'Victim Was Babysittee' then count end), 0) as babysittee,
coalesce(sum(case when relationship = 'Victim Was Boyfriend/Girlfriend' then count end), 0) as boyfriend_girlfriend,
coalesce(sum(case when relationship = 'Victim Was Child of Boyfriend or Girlfriend' then count end), 0) as child_boyfriend_girlfriend,
coalesce(sum(case when relationship = 'Victim Was Child' then count end), 0) as child,
coalesce(sum(case when relationship = 'Victim Was Common-Law Spouse' then count end), 0) as common_law_spouse,
coalesce(sum(case when relationship = 'Victim was Employee' then count end), 0) as employee,
coalesce(sum(case when relationship = 'Victim was Employer' then count end), 0) as employer,
coalesce(sum(case when relationship = 'Victim Was Friend' then count end), 0) as friend,
coalesce(sum(case when relationship = 'Victim Was Grandchild' then count end), 0) as grandchild,
coalesce(sum(case when relationship = 'Victim Was Grandparent' then count end), 0) as grandparent,
coalesce(sum(case when relationship = 'Homosexual Relationship' then count end), 0) as homosexual_relationship,
coalesce(sum(case when relationship = 'Victim Was In-law' then count end), 0) as in_law,
coalesce(sum(case when relationship = 'Victim Was Neighbor' then count end), 0) as neighbor,
coalesce(sum(case when relationship = 'Victim Was Other Family Member' then count end), 0) as other_family_member,
coalesce(sum(case when relationship = 'Victim was Otherwise Known' then count end), 0) as otherwise_known,
coalesce(sum(case when relationship = 'Victim Was Parent' then count end), 0) as parent,
coalesce(sum(case when relationship = 'Relationship Unknown' then count end), 0) as relationship_unknown,
coalesce(sum(case when relationship = 'Victim Was Sibling' then count end), 0) as sibling,
coalesce(sum(case when relationship = 'Victim Was Stepchild' then count end), 0) as stepchild,
coalesce(sum(case when relationship = 'Victim Was Spouse' then count end), 0) as spouse,
coalesce(sum(case when relationship = 'Victim Was Stepparent' then count end), 0) as stepparent,
coalesce(sum(case when relationship = 'Victim Was Stepsibling' then count end), 0) as stepsibling,
coalesce(sum(case when relationship = 'Victim Was Stranger' then count end), 0) as stranger,
coalesce(sum(case when relationship = 'Victim Was Offender' then count end), 0) as offender,
coalesce(sum(case when relationship = 'Victim was Ex-Spouse' then count end), 0) as ex_spouse
from public.nibrs_victim_to_offender_relationship_count group by agency_id, ori, offense_name, data_year;


UPDATE nibrs_victim_to_offender_relationship_count
SET  state_abbr = TRIM(state_abbr), ori= TRIM(ori), offense_name = TRIM(offense_name),relationship = TRIM(relationship)
