-- 
-- Created by SQL::Translator::Producer::Oracle
-- Created on Tue Nov  5 13:31:51 2013
-- 
--
-- Table: PP_ATTRIBUTES
--;

DROP TABLE "PP_ATTRIBUTES" CASCADE CONSTRAINTS;

CREATE TABLE "PP_ATTRIBUTES" (
  "ATTRIBUTE_ID" number(11) NOT NULL,
  "ATTRIBUTE_NAME" varchar2(100) NOT NULL,
  PRIMARY KEY ("ATTRIBUTE_ID"),
  CONSTRAINT "u_PP_ATTRIBUTES_name" UNIQUE ("ATTRIBUTE_NAME")
)
ENGINE    InnoDB;

--
-- Table: PP_GROUPS
--;

DROP TABLE "PP_GROUPS" CASCADE CONSTRAINTS;

CREATE TABLE "PP_GROUPS" (
  "GROUP_ID" number(11) NOT NULL,
  "GID" number(11) NOT NULL,
  "GROUP_NAME" varchar2(50),
  "GROUP_DESC" varchar2(100),
  PRIMARY KEY ("GROUP_ID"),
  CONSTRAINT "u_PP_GROUPS_GID" UNIQUE ("GID")
)
ENGINE    InnoDB;

--
-- Table: PP_STATUSES
--;

DROP TABLE "PP_STATUSES" CASCADE CONSTRAINTS;

CREATE TABLE "PP_STATUSES" (
  "STATUS_ID" number(11) NOT NULL,
  "STATUS_NAME" varchar2(100),
  "AD_PASSWORD" number(1),
  "AUTOMOUNTER" number(1),
  "AD_ENABLED" number(1),
  "TRUST_ALLOWED" number(1),
  "UNIX_PASSWD" number(1),
  "UNIX_ENABLED" number(1),
  "PROP_TEACH" number(1),
  "PROP_MAIL" number(1),
  "PROP_DIVA" number(1),
  "PROP_DIVB" number(1),
  "PROP_DIVF" number(1),
  "PROP_FLUID" number(1),
  "PROP_STRUCT" number(1),
  "PROP_WHITTLE" number(1),
  "PROP_WORKS" number(1),
  "PROP_TEST" number(1),
  PRIMARY KEY ("STATUS_ID"),
  CONSTRAINT "PP_STATUSES_STATUS_NAME" UNIQUE ("STATUS_NAME")
)
ENGINE    InnoDB;

--
-- Table: PP_USERS
--;

DROP TABLE "PP_USERS" CASCADE CONSTRAINTS;

CREATE TABLE "PP_USERS" (
  "USER_ID" number(11) NOT NULL,
  "CRSID" varchar2(10) NOT NULL,
  "ENGID" varchar2(4000),
  "UID" number(11) NOT NULL,
  "GECOS" varchar2(100),
  "HOMEDIR" varchar2(100),
  "PASSWORD_EXPIRY_DATE" varchar2(100),
  "PROPAGATION" varchar2(100),
  "STATUS_ID" number(11) NOT NULL,
  "STATUS_DATE" date,
  PRIMARY KEY ("USER_ID"),
  CONSTRAINT "u_PP_USERS_CRSID" UNIQUE ("CRSID"),
  CONSTRAINT "u_PP_USERS_ENGID" UNIQUE ("ENGID"),
  CONSTRAINT "u_PP_USERS_both" UNIQUE ("ENGID", "CRSID")
)
ENGINE    InnoDB;

--
-- Table: PP_USER_CAPABILITIES
--;

DROP TABLE "PP_USER_CAPABILITIES" CASCADE CONSTRAINTS;

CREATE TABLE "PP_USER_CAPABILITIES" (
  "CAPABILITIES_ID" number(11) NOT NULL,
  "USER_ID" number(11) NOT NULL,
  "AD_ENABLED" number(1),
  "AD_PASSWORD" number(1),
  "AUTOMOUNTER" number(1),
  "TRUST_ALLOWED" number(1),
  "UNIX_PASSWD" number(1),
  "UNIX_ENABLED" number(1),
  "PROP_TEACH" number(1),
  "PROP_MAIL" number(1),
  "PROP_DIVA" number(1),
  "PROP_DIVB" number(1),
  "PROP_DIVF" number(1),
  "PROP_FLUID" number(1),
  "PROP_STRUCT" number(1),
  "PROP_WHITTLE" number(1),
  "PROP_WORKS" number(1),
  "PROP_TEST" number(1),
  PRIMARY KEY ("CAPABILITIES_ID"),
  CONSTRAINT "PP_USER_CAPABILITIES_CAPABILITIES_ID_USER_ID" UNIQUE ("CAPABILITIES_ID", "USER_ID")
)
ENGINE    InnoDB;

--
-- Table: PP_GROUP_MEMBERSHIPS
--;

DROP TABLE "PP_GROUP_MEMBERSHIPS" CASCADE CONSTRAINTS;

CREATE TABLE "PP_GROUP_MEMBERSHIPS" (
  "GROUP_MEMBERSHIP_ID" number(11) NOT NULL,
  "USER_ID" number(11) NOT NULL,
  "GROUP_ID" number(11) NOT NULL,
  "PRIMARY_GROUP" number(1) NOT NULL,
  "AFFILIATION_GROUP" number(1) NOT NULL,
  PRIMARY KEY ("GROUP_MEMBERSHIP_ID"),
  CONSTRAINT "u_PP_GROUP_MEMBERSHIPS_affilia" UNIQUE ("GROUP_MEMBERSHIP_ID", "AFFILIATION_GROUP"),
  CONSTRAINT "u_PP_GROUP_MEMBERSHIPS_both" UNIQUE ("GROUP_MEMBERSHIP_ID", "PRIMARY_GROUP", "AFFILIATION_GROUP"),
  CONSTRAINT "u_PP_GROUP_MEMBERSHIPS_primary" UNIQUE ("GROUP_MEMBERSHIP_ID", "PRIMARY_GROUP")
)
ENGINE    InnoDB;

--
-- Table: PP_USER_ATTRIBUTES
--;

DROP TABLE "PP_USER_ATTRIBUTES" CASCADE CONSTRAINTS;

CREATE TABLE "PP_USER_ATTRIBUTES" (
  "USER_ATTRIBUTE_ID" number(11) NOT NULL,
  "USER_ID" number(11) NOT NULL,
  "ATTRIBUTE_ID" number(11) NOT NULL,
  "ATTRIBUTE_VALUE" varchar2(100),
  "ATTRIBUTE_EFFECTIVE_DATE" date,
  "ATTRIBUTE_EXPIRY_DATE" date,
  PRIMARY KEY ("USER_ATTRIBUTE_ID"),
  CONSTRAINT "u_PP_USER_ATTRIBUTES_both" UNIQUE ("USER_ID", "ATTRIBUTE_EFFECTIVE_DATE", "ATTRIBUTE_EXPIRY_DATE"),
  CONSTRAINT "u_PP_USER_ATTRIBUTES_effective" UNIQUE ("USER_ID", "ATTRIBUTE_EFFECTIVE_DATE"),
  CONSTRAINT "u_PP_USER_ATTRIBUTES_expiry" UNIQUE ("USER_ID", "ATTRIBUTE_EXPIRY_DATE")
)
ENGINE    InnoDB;

ALTER TABLE "PP_USERS" ADD CONSTRAINT "PP_USERS_STATUS_ID_fk" FOREIGN KEY ("STATUS_ID") REFERENCES "PP_STATUSES" ("STATUS_ID") ON DELETE CASCADE;

ALTER TABLE "PP_USER_CAPABILITIES" ADD CONSTRAINT "PP_USER_CAPABILITIES_USER_ID_f" FOREIGN KEY ("USER_ID") REFERENCES "PP_USERS" ("USER_ID") ON DELETE CASCADE;

ALTER TABLE "PP_GROUP_MEMBERSHIPS" ADD CONSTRAINT "PP_GROUP_MEMBERSHIPS_GROUP_ID_" FOREIGN KEY ("GROUP_ID") REFERENCES "PP_GROUPS" ("GROUP_ID") ON DELETE CASCADE;

ALTER TABLE "PP_GROUP_MEMBERSHIPS" ADD CONSTRAINT "PP_GROUP_MEMBERSHIPS_USER_ID_f" FOREIGN KEY ("USER_ID") REFERENCES "PP_USERS" ("USER_ID") ON DELETE CASCADE;

ALTER TABLE "PP_USER_ATTRIBUTES" ADD CONSTRAINT "PP_USER_ATTRIBUTES_ATTRIBUTE_I" FOREIGN KEY ("ATTRIBUTE_ID") REFERENCES "PP_ATTRIBUTES" ("ATTRIBUTE_ID");

ALTER TABLE "PP_USER_ATTRIBUTES" ADD CONSTRAINT "PP_USER_ATTRIBUTES_USER_ID_fk" FOREIGN KEY ("USER_ID") REFERENCES "PP_USERS" ("USER_ID") ON DELETE CASCADE;

CREATE INDEX "PP_USERS_idx_STATUS_ID" on "PP_USERS" ("STATUS_ID");

CREATE INDEX "PP_USER_CAPABILITIES_idx_USER_" on "PP_USER_CAPABILITIES" ("USER_ID");

CREATE INDEX "PP_GROUP_MEMBERSHIPS_idx_GROUP" on "PP_GROUP_MEMBERSHIPS" ("GROUP_ID");

CREATE INDEX "PP_GROUP_MEMBERSHIPS_idx_USER_" on "PP_GROUP_MEMBERSHIPS" ("USER_ID");

CREATE INDEX "PP_USER_ATTRIBUTES_idx_ATTRIBU" on "PP_USER_ATTRIBUTES" ("ATTRIBUTE_ID");

CREATE INDEX "PP_USER_ATTRIBUTES_idx_USER_ID" on "PP_USER_ATTRIBUTES" ("USER_ID");

/

