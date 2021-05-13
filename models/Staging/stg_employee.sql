with source as(
    select distinct
        businessentityid
        , loginid
        , nationalidnumber
        , jobtitle
        , organizationnode
        , hiredate
        , gender
        , birthdate
        , currentflag
        , salariedflag
        , maritalstatus
        , vacationhours
        , sickleavehours
        , rowguid
        , modifieddate
    from {{ source('adventureworkselt','employee')}}
)
select *
from source