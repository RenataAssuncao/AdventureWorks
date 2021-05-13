with
    person as (
        select 
            businessentityid
            , firstname
            , middlename
            , lastname
            , title
        from {{ ref('stg_person')}}
    )
    , employee as (
        select distinct
            employee.businessentityid
            , loginid
            , nationalidnumber
            , jobtitle
            , organizationnode
            , firstname
            , middlename
            , lastname
            , title
            , hiredate
            , gender
            , birthdate
            , currentflag
            , salariedflag
            , maritalstatus
            , vacationhours
            , sickleavehours
            , modifieddate
        from {{ ref('stg_employee') }} as employee
        left join person on employee.businessentityid = person.businessentityid
    )
    , transformed as (
        select 
            row_number () over (order by businessentityid) as employee_sk -- chave surrogate auto incremental
            , *
        from employee
    ) 
select *
from transformed