---- add primary keys ----
alter table DB1_Users add primary key (userId);
alter table DB1_Taverns add primary key (TavernId);
alter table DB1_Location add primary key (locationId);
alter table DB1_Roles add primary key (Id);
alter table DB1_BasementRats add primary key (ratId);
alter table DB1_Sales add primary key (salesId);
alter table DB1_Supplies add primary key (supplyId);
alter table DB1_TavernStock add primary key (stockId);
alter table DB1_SuppliesRcvd add primary key (rcvdId);
alter table DB1_Services add primary key (sericeId);
alter table DB1_ServiceStatus add primary key (statusId);
alter table DB1_Guests add primary key (guestId);
alter table DB1_GuestStatus add primary key (statusId);
alter table DB1_Class add constraint pk_classLevel (class, level);

---- add foreign keys ----
alter table DB1_Users add foreign key (roleId) references DB1_Roles(Id);
alter table DB1_Taverns add foreign key (LocationId) references DB1_location(locationId);
alter table DB1_Taverns add foreign key (OwnerId) references DB1_Users(userId);
alter table DB1_BasementRats add foreign key (tavernId) references DB1_Taverns(tavernId);
alter table DB1_Sales add foreign key (supplyId) references DB1_Supplies(supplyId);
alter table DB1_Sales add foreign key (tavernId) references DB1_taverns(tavernId);
alter table DB1_Sales add foreign key (guestId) references DB1_Guests(guestId);
alter table DB1_TavernStock add foreign key (tavernId) references DB1_Taverns(tavernId);
alter table DB1_TavernStock add foreign key (supplyId) references DB1_supplies(supplyId);
alter table DB1_SuppliesRcvd add foreign key (supplyId) references DB1_Supplies(SupplyId);
alter table DB1_SuppliesRcvd add foreign key (tavernId) references DB1_Taverns(tavernId);
alter table DB1_Services add foreign key (statusId) references DB1_serviceStatus(statusId);
alter table DB1_Guests add foreign key (guestId) references DB1_GuestStatus(guestId);
alter table DB1_Class add foreign key (guestId) references DB1_guests(guestId);
