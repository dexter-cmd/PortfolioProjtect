Select*
From PorfolioProject.dbo.NashvilleHousing

--change date formate 

Alter table NashvilleHousing
Add SalesDateConverted Date 

update NashvilleHousing
Set SalesDateConverted = Convert (Date,SaleDate)

Select SalesDateConverted 
From PorfolioProject.Dbo.NashvilleHousing

--

Select *
From PorfolioProject.Dbo.NashvilleHousing
Where PropertyAddress is null 
Order by ParcelID

Select *
From PorfolioProject.Dbo.NashvilleHousing
--Where PropertyAddress is null 
Order by ParcelID
 -- found that same Id is having same address 

 Select a.ParcelID, a.PropertyAddress, b.ParcelID, B.PropertyAddress , ISNULL(a.PropertyAddress ,B.PropertyAddress )
From PorfolioProject.Dbo.NashvilleHousing a
Join PorfolioProject.Dbo.NashvilleHousing b
     on a.ParcelID = b.ParcelID
	 And a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is Null
-- Populate the null values with the other values 

update a
set PropertyAddress = ISNULL(a.PropertyAddress ,B.PropertyAddress )
From PorfolioProject.Dbo.NashvilleHousing a
Join PorfolioProject.Dbo.NashvilleHousing b
     on a.ParcelID = b.ParcelID
	 And a.[UniqueID ] <> b.[UniqueID ]
 -- updated 

 -- 
 Select PropertyAddress
 from PorfolioProject.dbo.NashvilleHousing

 Select 
 Substring(PropertyAddress,1, Charindex(',' , PropertyAddress)- 1)  as StreetAddress ,
 Substring(PropertyAddress, Charindex(',' , PropertyAddress) +1, Len(PropertyAddress)) as City  
 From PorfolioProject.dbo.NashvilleHousing

 -- seperated city from Street 

 --create column to our table with splitted address  
 
Alter table Nashvillehousing 
Add PropertySplitAdress Nvarchar(255) 

 Alter Table NashvilleHousing 
 Add PropertySplitcity Nvarchar(255)

-- update or fill the table with sliptted address 

Update NashvilleHousing
Set PropertySplitAdress = Substring(PropertyAddress,1, Charindex(',' , PropertyAddress)- 1)  

Update NashvilleHousing
Set PropertySplitcity = Substring(PropertyAddress, Charindex(',' , PropertyAddress) +1, Len(PropertyAddress))

--Check
Select* 
From PorfolioProject.dbo.NashvilleHousing

-- slpit owner address 
Select OwnerAddress
From PorfolioProject.dbo.NashvilleHousing

Select 
PARSENAME(Replace(OwnerAddress, ',','.') ,3)
,PARSENAME(Replace(OwnerAddress, ',','.') ,2)
,PARSENAME(REplace(OwnerAddress, ',','.') ,1)
From PorfolioProject.dbo.NashvilleHousing

-- create column for ownersplitcity 

 Alter Table NashvilleHousing 
 Add ownerslpitAddress Nvarchar(255)

  Alter Table NashvilleHousing 
 Add ownerslpitCity Nvarchar(255)

  Alter Table NashvilleHousing 
 Add ownerslpitStates Nvarchar(255)


 --Insert values in the blank column 

 Update NashvilleHousing
Set ownerslpitAddress = PARSENAME(REplace(OwnerAddress, ',','.') ,3) 


Update NashvilleHousing
Set ownerslpitCity = PARSENAME(REplace(OwnerAddress, ',','.') ,2)  

Update NashvilleHousing
Set ownerslpitStates = PARSENAME(REplace(OwnerAddress, ',','.') ,1)  

--
Select distinct(SoldAsVacant), count(SoldAsVacant)
From PorfolioProject.dbo.NashvilleHousing
Group by SoldAsVacant

Select SoldAsVacant ,
Case When SoldAsVacant = 'Y' then 'Yes'
     When SoldAsVacant = 'N' then 'No'
	 Else SoldAsVacant
	 End
From PorfolioProject.dbo.NashvilleHousing

Update NashvilleHousing
set SoldAsVacant = Case When SoldAsVacant = 'Y' then 'Yes'
     When SoldAsVacant = 'N' then 'No'
	 Else SoldAsVacant
	 End

	 ----------------------------------
	 --Remove Duplicates 
With RowNumCTE As(
Select*,
  Row_Number()Over(
  Partition by ParcelID,
               PropertyAddress,
			   SaleDate,
			   SalePrice,
			   LegalReference
			   Order by
			   UniqueID
			   )Row_num

From PorfolioProject.dbo.NashvilleHousing
--Order by ParcelID
)
Select * 
From RowNumCTE
Where Row_num > 1
Order by PropertyAddress


---------------------------------

Alter Table PorfolioProject.dbo.NashvilleHousing
Drop Column OwnerAddress, TaxDistrict, PropertyAddress

Alter Table PorfolioProject.dbo.NashvilleHousing
Drop Column SaleDate


