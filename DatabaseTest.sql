CREATE TABLE [DashboardType]{
    Id int PRIMARY KEY NOT NULL IDENTITY(1000,1),
    DashboardTypeName varchar(100) NOT NULL
};

CREATE TABLE [AddressType]{
    Id int PRIMARY KEY NOT NULL IDENTITY(1,1),
    AddressType varchar(100) NOT NULL
};

CREATE TABLE [Contact]{
    Id int PRIMARY KEY NOT NULL IDENTITY(1,1),
    ContactName varchar(100) NOT NULL,
    PhoneNumber int NOT NULL,
    PhoneNumber2 int NULL,
    Email varchar(100) NOT NULL,
    DateCreated datetime NOT NULL DEFAULT GETDATE(),
    DateModified datetime NULL 
};

CREATE TABLE [Country]{
    Id int PRIMARY KEY NOT NULL IDENTITY(1,1),
    CountryName varchar(100) NOT NULL
};

CREATE TABLE [Language]{
    Id int PRIMARY KEY NOT NULL IDENTITY(1,1),
    LanguageName varchar(100) NOT NULL,
    NativeName varchar(100) NULL
};

CREATE TABLE [Salesmanager]{
    Id int PRIMARY KEY NOT NULL IDENTITY(1,1),
    SalesmanagerName varchar(100) NOT NULL
};

CREATE TABLE [Accountmanager]{
    Id int PRIMARY KEY NOT NULL IDENTITY(1,1),
    AccountmanagerName varchar(100) NOT NULL
};

CREATE TABLE [Carrier]{
    Id int PRIMARY KEY NOT NULL IDENTITY(1,1),
    CarrierName varchar(100) NOT NULL
}

CREATE TABLE [ProductLine]{
    Id int PRIMARY KEY NOT NULL IDENTITY(1,1),
    ProductLineName varchar(100) NOT NULL
};

CREATE TABLE [ChargeType]{
    Id int PRIMARY KEY NOT NULL IDENTITY(1,1),
    ChargeType varchar(100) NOT NULL
};

CREATE TABLE [Address]{
    Id int PRIMARY KEY NOT NULL IDENTITY(1,1),
    AddressLine1 varchar(100) NOT NULL,
    AddressLine2 varchar(100) NULL,
    AddressLine3 varchar(100) NULL, 
    PostalCode varchar(16) NOT NULL,
    City varchar(100) NOT NULL,
    StateName varchar(100) NULL,
    CountryId int,
    DateCreated datetime NOT NULL DEFAULT GETDATE(),
    DateModified datetime NULL,
        CONSTRAINT Fk_Address_CountryId FOREIGN KEY (CountryId)
        REFERENCES [Country](Id)
};

CREATE TABLE [Bank]{
    Id int PRIMARY KEY NOT NULL IDENTITY(1,1),
    BankName varchar(100) NOT NULL,
    BankBic varchar(100) NOT NULL,
    CountryId int,
     CONSTRAINT Fk_Bank_CountryId FOREIGN KEY (CountryId)
        REFERENCES [Country](Id)
};

CREATE TABLE [Billing]{
    Id int PRIMARY KEY NOT NULL IDENTITY(1,1),
    BillingEmailAddress varchar(100) NOT NULL,
    BillingPhoneNumber int NOT NULL,
    IbanNumber varchar(100) NOT NULL,
    BankId int,
    DateCreated datetime NOT NULL DEFAULT GETDATE(),
    DateModified datetime NULL,
     CONSTRAINT Fk_Billing_BankId FOREIGN KEY (BankId)
        REFERENCES [Bank](Id)
};

CREATE TABLE [Carrier_Address]{
    CarrierId int, 
    AddressId int, 
    DateCreated datetime NOT NULL DEFAULT GETDATE(),
    DateModified datetime NULL,
        CONSTRAINT Fk_Carrier_Id FOREIGN KEY (CarrierId)
        REFERENCES [Carrier](Id),
        CONSTRAINT Fk_Address_Id FOREIGN KEY (AddressId)
        REFERENCES [Address](Id)
};

CREATE TABLE [Carrier_Billing]{
    CarrierId int, 
    BillingId int, 
    DateCreated datetime NOT NULL DEFAULT GETDATE(),
    DateModified datetime NULL,
        CONSTRAINT Fk_Carrier_Id FOREIGN KEY (CarrierId)
        REFERENCES [Carrier](Id),
        CONSTRAINT Fk_Billing_Id FOREIGN KEY (BillingId)
        REFERENCES [Billing](Id)
};

CREATE TABLE [Company]{
    Id int PRIMARY KEY NOT NULL IDENTITY(1,1),
    CompanyName varchar NOT NULL,
    CocNumber int NOT NULL,
    VatNumber int NOT NULL, 
    SalesmanagerId int,
    AccountmanagerId int,
    KeyAccount bit NOT NULL DEFAULT 0,
    AdvanceFee bit NOT NULL DEFAULT 0,
    DateCreated datetime NOT NULL DEFAULT GETDATE(),
    DateModified datetime NULL,
        CONSTRAINT Fk_Salesmanager_Id FOREIGN KEY (SalesmanagerId)
        REFERENCES [Salesmanager](Id),
        CONSTRAINT Fk_Accountmanager_Id FOREIGN KEY (AccountmanagerId)
        REFERENCES [Accountmanager](Id)
};

CREATE TABLE [Company_Address]{
    CompanyId int, 
    AddressId int, 
    DateCreated datetime NOT NULL DEFAULT GETDATE(),
    DateModified datetime NULL,
        CONSTRAINT Fk_Company_Id FOREIGN KEY (CompanyId)
        REFERENCES [Company](Id),
        CONSTRAINT Fk_Address_Id FOREIGN KEY (AddressId)
        REFERENCES [Address](Id)
};

CREATE TABLE [Company_Billing]{
    CompanyId int, 
    BillingId int, 
    DateCreated datetime NOT NULL DEFAULT GETDATE(),
    DateModified datetime NULL,
        CONSTRAINT Fk_Company_Id FOREIGN KEY (CompanyId)
        REFERENCES [Company](Id),
        CONSTRAINT Fk_Billing_Id FOREIGN KEY (BillingId)
        REFERENCES [Billing](Id)
};

CREATE TABLE [Surcharge]{
    Id int PRIMARY KEY NOT NULL IDENTITY(1,1),
    SurchargeName varchar(100) NOT NULL,
    SurchargeAbbreviation varchar(3) NOT NULL,
    ChargeTypeId int, 
    DateCreated datetime NOT NULL DEFAULT GETDATE(),
    DateModified datetime NULL,
    CONSTRAINT Fk_Surcharge_ChargeTypeId FOREIGN KEY (ChargeTypeId)
        REFERENCES [ChargeType](Id)
};

CREATE TABLE [Dashboard]{
    Id int PRIMARY KEY NOT NULL IDENTITY(1,1),
    DashboardName varchar(100) NOT NULL,
    DashboardTypeId int,
    DashboardParentId int NULL,
    CompanyId int,
    DateCreated datetime NOT NULL DEFAULT GETDATE(),
    DateModified datetime NULL,
        CONSTRAINT Fk_Dashboard_Type_Id FOREIGN KEY (DashboardTypeId)
        REFERENCES [DashboardType](Id),
        CONSTRAINT Fk_Dashboard_Parent_Id FOREIGN KEY(DashboardParentId)
        REFERENCES [Dashboard](Id),
        CONSTRAINT Fk_Company_Id FOREIGN KEY (CompanyId)
        REFERENCES [Company](Id)
};

CREATE TABLE [User]{
    Id int PRIMARY KEY NOT NULL IDENTITY(1,1),
    DashboardId int,
    CompanyId int, 
    LanguageId int,
    ContactId int, 
    Active bit NOT NULL,
    DateCreated datetime NOT NULL DEFAULT GETDATE(),
    DateModified datetime NULL,
        CONSTRAINT Fk_Dashboard_Id FOREIGN KEY (DashboardId)
        REFERENCES [Dashboard](Id),
        CONSTRAINT Fk_Company_Id FOREIGN KEY (CompanyId)
        REFERENCES [Company](Id),
        CONSTRAINT Fk_Language_Id FOREIGN KEY (LanguageId)
        REFERENCES [Language](Id),
        CONSTRAINT Fk_Contact_Id FOREIGN KEY (ContactId)
        REFERENCES [Contact](Id)
};

CREATE TABLE [Login]{
    Id int PRIMARY KEY NOT NULL IDENTITY(1,1),
    Username varchar(100) NOT NULL UNIQUE,
    HashedPassword varchar(100) NOT NULL,
    Salt varchar (100) NOT NULL, 
    UserId int,
        CONSTRAINT Fk_User_Id FOREIGN KEY (UserId)
        REFERENCES [User](Id)
}