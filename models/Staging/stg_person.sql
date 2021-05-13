with source as(
    select distinct
        businessentityid
        , firstname
        , middlename
        , lastname
        , title
        , suffix
        , namestyle			
        , persontype
        , emailpromotion			
		, rowguid
		, modifieddate			
    from {{ source('adventureworkselt','person')}}
)
select *
from source