/*==============================================================*/
/* Créé le
/* 18 mars 2019
/* Ajouter une description
/* Les lecteurs peuvent télécharger
/* Nom de SGBD :  ORACLE Version 11g                            */
/* Date de création :  18/03/2019 15:02:15                      */
/*==============================================================*/


alter table EXPERIENCE
   drop constraint FK_EXPERIEN_CORRESPON_LIGNE_FA;

alter table FACTURE
   drop constraint FK_FACTURE_DOIT_PAYE_EQUIPE;

alter table FAIT
   drop constraint FK_FAIT_FAIT_PERSONNE;

alter table FAIT
   drop constraint FK_FAIT_FAIT2_EXPERIEN;

alter table HISTO_EXPERIENCE
   drop constraint FK_HISTO_EX_A_FAIT_PERSONNE;

alter table HISTO_EXPERIENCE
   drop constraint FK_HISTO_EX_HISTORISE_EXPERIEN;

alter table HISTO_PHOTOMETRE
   drop constraint FK_HISTO_PH_A_MODIFIE_PERSONNE;

alter table HISTO_PHOTOMETRE
   drop constraint FK_HISTO_PH_HISTORISE_PHOTOMET;

alter table LIGNE_FACTURE
   drop constraint FK_LIGNE_FA_CORRESPON_EXPERIEN;

alter table LIGNE_FACTURE
   drop constraint FK_LIGNE_FA_EST_REMPL_FACTURE;

alter table N_UPLET
   drop constraint FK_N_UPLET_ACQUIERT_EXPERIEN;

alter table N_UPLET
   drop constraint FK_N_UPLET_CONTIENT_RESULTAT;

alter table N_UPLET
   drop constraint FK_N_UPLET_RECOIT_SOLUTION;

alter table PERSONNE
   drop constraint FK_PERSONNE_EST_DANS_EQUIPE;

alter table PLAQUE
   drop constraint FK_PLAQUE_DEFINI_TYPE_PLA;

alter table PUIT
   drop constraint FK_PUIT_FORME_N_UPLET;

alter table PUIT
   drop constraint FK_PUIT_POSSEDE_PLAQUE;

alter table RESULTAT_PUIT
   drop constraint FK_RESULTAT_A_UN_PUIT;

alter table RESULTAT_PUIT
   drop constraint FK_RESULTAT_CALCULE_RESULTAT;

alter table RESULTAT_PUIT
   drop constraint FK_RESULTAT_CREE_PHOTOMET;

alter table SOLUTION
   drop constraint FK_SOLUTION_ASSOCIATI_CELLULE;

alter table SOLUTION
   drop constraint FK_SOLUTION_COMPORTE_AGENT_BI;

drop table AGENT_BIOLOGIQUE cascade constraints;

drop table CELLULE cascade constraints;

drop table EQUIPE cascade constraints;

drop index CORRESPOND_FK;

drop table EXPERIENCE cascade constraints;

drop index DOIT_PAYER_FK;

drop table FACTURE cascade constraints;

drop index FAIT2_FK;

drop index FAIT_FK;

drop table FAIT cascade constraints;

drop index A_FAIT_FK;

drop index HISTORISEEXP_FK;

drop table HISTO_EXPERIENCE cascade constraints;

drop index A_MODIFIE_FK;

drop index HISTORISEPHOTO_FK;

drop table HISTO_PHOTOMETRE cascade constraints;

drop index CORRESPOND2_FK;

drop index EST_REMPLIE_FK;

drop table LIGNE_FACTURE cascade constraints;

drop index ACQUIERT_FK;

drop index RECOIT_FK;

drop index CONTIENT_FK;

drop table N_UPLET cascade constraints;

drop index EST_DANS_FK;

drop table PERSONNE cascade constraints;

drop table PHOTOMETRE cascade constraints;

drop index DEFINI_FK;

drop table PLAQUE cascade constraints;

drop index FORME_FK;

drop index POSSEDE_FK;

drop table PUIT cascade constraints;

drop table RESULTAT_N_UPLET cascade constraints;

drop index CREE_FK;

drop index CALCULE_FK;

drop index A_UN_FK;

drop table RESULTAT_PUIT cascade constraints;

drop index ASSOCIATION_5_FK;

drop index COMPORTE_FK;

drop table SOLUTION cascade constraints;

drop table TYPE_PLAQUE cascade constraints;

/*==============================================================*/
/* Table : AGENT_BIOLOGIQUE                                     */
/*==============================================================*/
create table AGENT_BIOLOGIQUE 
(
   ID_AGENT_BIO         INTEGER              not null,
   QTEA                 NUMBER               not null
      constraint CKC_QTEA_AGENT_BI check (QTEA >= 0),
   NOMA                 VARCHAR2(50)         not null
      constraint CKC_NOMA_AGENT_BI check (NOMA = lower(NOMA)),
   PRIXA                NUMBER               not null
      constraint CKC_PRIXA_AGENT_BI check (PRIXA >= 0),
   constraint PK_AGENT_BIOLOGIQUE primary key (ID_AGENT_BIO)
);

/*==============================================================*/
/* Table : CELLULE                                              */
/*==============================================================*/
create table CELLULE 
(
   ID_CELL_CANCEREUSE   INTEGER              not null,
   TYPE_CELLULAIRE      VARCHAR2(50)         not null
      constraint CKC_TYPE_CELLULAIRE_CELLULE check (TYPE_CELLULAIRE in ('celluleCancereuse','celluleNonCancereuse')),
   QTEC                 NUMBER               not null
      constraint CKC_QTEC_CELLULE check (QTEC >= 0),
   NOMC                 VARCHAR2(50)         not null
      constraint CKC_NOMC_CELLULE check (NOMC = lower(NOMC)),
   PRIXC                NUMBER               not null
      constraint CKC_PRIXC_CELLULE check (PRIXC >= 0),
   constraint PK_CELLULE primary key (ID_CELL_CANCEREUSE)
);

/*==============================================================*/
/* Table : EQUIPE                                               */
/*==============================================================*/
create table EQUIPE 
(
   ID_EQUIPE            INTEGER              not null,
   ADRESSE              CLOB                 not null,
   constraint PK_EQUIPE primary key (ID_EQUIPE)
);

/*==============================================================*/
/* Table : EXPERIENCE                                           */
/*==============================================================*/
create table EXPERIENCE 
(
   ID_EXPERIENCE        INTEGER              not null,
   ID_LIGNE             INTEGER,
   NOMEXP               VARCHAR2(100)        not null,
   ETAT_EXP             VARCHAR2(50)         not null
      constraint CKC_ETAT_EXP_EXPERIEN check (ETAT_EXP in ('enCours','teminer','enAttente','facture')),
   DUREE                DATE                 not null,
   FREQUENCE            NUMBER,
   NBPUIT               INTEGER              not null
      constraint CKC_NBPUIT_EXPERIEN check (NBPUIT >= 1),
   TYPE_EXP             VARCHAR2(25)         not null
      constraint CKC_TYPE_EXP_EXPERIEN check (TYPE_EXP in ('immunologique','toxicite')),
   TYPE_ANALYSE         VARCHAR2(50)         not null
      constraint CKC_TYPE_ANALYSE_EXPERIEN check (TYPE_ANALYSE in ('colorimetrique','opacite')),
   APHA1                NUMBER               not null,
   ALPHA2               NUMBER               not null,
   ALPHA3               NUMBER              
      constraint CKC_ALPHA3_EXPERIEN check (ALPHA3 is null or (ALPHA3 between 0 and 1)),
   RESULTAT_EXP         VARCHAR2(25)         not null
      constraint CKC_RESULTAT_EXP_EXPERIEN check (RESULTAT_EXP in ('acceptee','refusee')),
   HORODATAGE_DEB       DATE                 not null,
   HORODATAGE_FIN       DATE,
   HD_DEMANDE_CHERCHEUR DATE                 not null,
   HD_TRANSMISSION_CHERCHEUR DATE,
   constraint PK_EXPERIENCE primary key (ID_EXPERIENCE)
);

/*==============================================================*/
/* Index : CORRESPOND_FK                                        */
/*==============================================================*/
create index CORRESPOND_FK on EXPERIENCE (
   ID_LIGNE ASC
);

/*==============================================================*/
/* Table : FACTURE                                              */
/*==============================================================*/
create table FACTURE 
(
   ID_FACTURE           INTEGER              not null,
   ID_EQUIPE            INTEGER              not null,
   "DATE"               DATE                 not null,
   constraint PK_FACTURE primary key (ID_FACTURE)
);

/*==============================================================*/
/* Index : DOIT_PAYER_FK                                        */
/*==============================================================*/
create index DOIT_PAYER_FK on FACTURE (
   ID_EQUIPE ASC
);

/*==============================================================*/
/* Table : FAIT                                                 */
/*==============================================================*/
create table FAIT 
(
   ID_PERSONNE          INTEGER              not null,
   ID_EXPERIENCE        INTEGER              not null,
   constraint PK_FAIT primary key (ID_PERSONNE, ID_EXPERIENCE)
);

/*==============================================================*/
/* Index : FAIT_FK                                              */
/*==============================================================*/
create index FAIT_FK on FAIT (
   ID_PERSONNE ASC
);

/*==============================================================*/
/* Index : FAIT2_FK                                             */
/*==============================================================*/
create index FAIT2_FK on FAIT (
   ID_EXPERIENCE ASC
);

/*==============================================================*/
/* Table : HISTO_EXPERIENCE                                     */
/*==============================================================*/
create table HISTO_EXPERIENCE 
(
   ID_HISTO_EXP         INTEGER              not null,
   ID_EXPERIENCE        INTEGER              not null,
   ID_PERSONNE          INTEGER              not null,
   HISTOEXP_HORODATAGE  DATE                 not null,
   HISTOEXP_TYPE        VARCHAR2(25)         not null
      constraint CKC_HISTOEXP_TYPE_HISTO_EX check (HISTOEXP_TYPE in ('creation','modifie','supprime')),
   HISTOEXP_ETAT_EXP    VARCHAR2(50)         not null
      constraint CKC_HISTOEXP_ETAT_EXP_HISTO_EX check (HISTOEXP_ETAT_EXP in ('enCours','teminer','enAttente','facture')),
   HISTOEXP_DUREE       DATE                 not null,
   HISTOEXP_FREQUENCE   NUMBER,
   HISTOEXP_NBPUIT      INTEGER              not null
      constraint CKC_HISTOEXP_NBPUIT_HISTO_EX check (HISTOEXP_NBPUIT >= 1),
   HISTOEXP_TYPE_EXP    VARCHAR2(25)         not null
      constraint CKC_HISTOEXP_TYPE_EXP_HISTO_EX check (HISTOEXP_TYPE_EXP in ('immunologique','toxicite')),
   HISTOEXP_TYPE_ANALYSE VARCHAR2(50)         not null
      constraint CKC_HISTOEXP_TYPE_ANA_HISTO_EX check (HISTOEXP_TYPE_ANALYSE in ('colorimetrique','opacite')),
   HISTOEXP_ALPHA1      NUMBER               not null,
   HISTOEXP_ALPHA2      NUMBER,
   HISTOEXP_ALPHA3      NUMBER              
      constraint CKC_HISTOEXP_ALPHA3_HISTO_EX check (HISTOEXP_ALPHA3 is null or (HISTOEXP_ALPHA3 between 0 and 1)),
   HISTOEXP_RESULTAT_EXP VARCHAR2(25)         not null
      constraint CKC_HISTOEXP_RESULTAT_HISTO_EX check (HISTOEXP_RESULTAT_EXP in ('acceptee','refusee')),
   HISTOEXP_HORODATAGE_DEB DATE,
   HISTOEXP_HORODATAGE_FIN DATE                 not null,
   HISTOEXP_HD_DEM_CHERCHEUR DATE,
   HISTOEXP_HD_TRANS_CHER DATE                 not null,
   constraint PK_HISTO_EXPERIENCE primary key (ID_HISTO_EXP)
);

/*==============================================================*/
/* Index : HISTORISEEXP_FK                                      */
/*==============================================================*/
create index HISTORISEEXP_FK on HISTO_EXPERIENCE (
   ID_EXPERIENCE ASC
);

/*==============================================================*/
/* Index : A_FAIT_FK                                            */
/*==============================================================*/
create index A_FAIT_FK on HISTO_EXPERIENCE (
   ID_PERSONNE ASC
);

/*==============================================================*/
/* Table : HISTO_PHOTOMETRE                                     */
/*==============================================================*/
create table HISTO_PHOTOMETRE 
(
   ID_HISTOPHOTOMETRE   INTEGER              not null,
   ID_PHOTOMETRE        INTEGER              not null,
   ID_PERSONNE          INTEGER              not null,
   HISTOPHOTOMETRE_HORODATAGE DATE                 not null,
   HISTOPHOTOMETRE_TYPE VARCHAR2(25)         not null
      constraint CKC_HISTOPHOTOMETRE_T_HISTO_PH check (HISTOPHOTOMETRE_TYPE in ('creation','modifie','supprime')),
   HISTOPHOTOMETRE_ETAT VARCHAR2(50)         not null
      constraint CKC_HISTOPHOTOMETRE_E_HISTO_PH check (HISTOPHOTOMETRE_ETAT in ('operationnel','defaillant')),
   HISTOPHOTOMETRE_PRIX_PAR_PHOTO NUMBER               not null
      constraint CKC_HISTOPHOTOMETRE_P_HISTO_PH check (HISTOPHOTOMETRE_PRIX_PAR_PHOTO >= 0),
   constraint PK_HISTO_PHOTOMETRE primary key (ID_HISTOPHOTOMETRE)
);

/*==============================================================*/
/* Index : HISTORISEPHOTO_FK                                    */
/*==============================================================*/
create index HISTORISEPHOTO_FK on HISTO_PHOTOMETRE (
   ID_PHOTOMETRE ASC
);

/*==============================================================*/
/* Index : A_MODIFIE_FK                                         */
/*==============================================================*/
create index A_MODIFIE_FK on HISTO_PHOTOMETRE (
   ID_PERSONNE ASC
);

/*==============================================================*/
/* Table : LIGNE_FACTURE                                        */
/*==============================================================*/
create table LIGNE_FACTURE 
(
   ID_LIGNE             INTEGER              not null,
   ID_EXPERIENCE        INTEGER              not null,
   ID_FACTURE           INTEGER              not null,
   PRIX                 NUMBER               not null,
   constraint PK_LIGNE_FACTURE primary key (ID_LIGNE)
);

/*==============================================================*/
/* Index : EST_REMPLIE_FK                                       */
/*==============================================================*/
create index EST_REMPLIE_FK on LIGNE_FACTURE (
   ID_FACTURE ASC
);

/*==============================================================*/
/* Index : CORRESPOND2_FK                                       */
/*==============================================================*/
create index CORRESPOND2_FK on LIGNE_FACTURE (
   ID_EXPERIENCE ASC
);

/*==============================================================*/
/* Table : N_UPLET                                              */
/*==============================================================*/
create table N_UPLET 
(
   ID_N_UPLET           INTEGER              not null,
   ID_RESULTAT_N_UPLET  INTEGER              not null,
   ID_EXPERIENCE        INTEGER              not null,
   ID_SOLUTION          INTEGER              not null,
   URGENT               SMALLINT             not null,
   constraint PK_N_UPLET primary key (ID_N_UPLET)
);

/*==============================================================*/
/* Index : CONTIENT_FK                                          */
/*==============================================================*/
create index CONTIENT_FK on N_UPLET (
   ID_RESULTAT_N_UPLET ASC
);

/*==============================================================*/
/* Index : RECOIT_FK                                            */
/*==============================================================*/
create index RECOIT_FK on N_UPLET (
   ID_SOLUTION ASC
);

/*==============================================================*/
/* Index : ACQUIERT_FK                                          */
/*==============================================================*/
create index ACQUIERT_FK on N_UPLET (
   ID_EXPERIENCE ASC
);

/*==============================================================*/
/* Table : PERSONNE                                             */
/*==============================================================*/
create table PERSONNE 
(
   ID_PERSONNE          INTEGER              not null,
   ID_EQUIPE            INTEGER,
   NOM                  VARCHAR2(50)         not null
      constraint CKC_NOM_PERSONNE check (NOM = lower(NOM)),
   PRENOM               VARCHAR2(50)         not null
      constraint CKC_PRENOM_PERSONNE check (PRENOM = lower(PRENOM)),
   FONCTION             VARCHAR2(50)         not null
      constraint CKC_FONCTION_PERSONNE check (FONCTION in ('laborantin','chercheur','secretaire','admin') and FONCTION = lower(FONCTION)),
   EMAIL                VARCHAR2(50)         not null
      constraint CKC_EMAIL_PERSONNE check (EMAIL = lower(EMAIL)),
   MOT_DE_PASSE         VARCHAR2(50)         not null,
   constraint PK_PERSONNE primary key (ID_PERSONNE)
);

/*==============================================================*/
/* Index : EST_DANS_FK                                          */
/*==============================================================*/
create index EST_DANS_FK on PERSONNE (
   ID_EQUIPE ASC
);

/*==============================================================*/
/* Table : PHOTOMETRE                                           */
/*==============================================================*/
create table PHOTOMETRE 
(
   ID_PHOTOMETRE        INTEGER              not null,
   ETAT_PHOTOTMETRE     VARCHAR2(50)         not null
      constraint CKC_ETAT_PHOTOTMETRE_PHOTOMET check (ETAT_PHOTOTMETRE in ('operationnel','defaillant')),
   PRIX_PAR_PHOTO       NUMBER               not null
      constraint CKC_PRIX_PAR_PHOTO_PHOTOMET check (PRIX_PAR_PHOTO >= 0),
   constraint PK_PHOTOMETRE primary key (ID_PHOTOMETRE)
);

comment on table PHOTOMETRE is
'Gestion des photomètres';

/*==============================================================*/
/* Table : PLAQUE                                               */
/*==============================================================*/
create table PLAQUE 
(
   ID_PLAQUE            INTEGER              not null,
   TYPE_PLAQUE          VARCHAR2(25)         not null
      constraint CKC_TYPE_PLAQUE_PLAQUE check (TYPE_PLAQUE in ('96puits','384puits')),
   constraint PK_PLAQUE primary key (ID_PLAQUE)
);

comment on table PLAQUE is
'Gestion des plaques';

/*==============================================================*/
/* Index : DEFINI_FK                                            */
/*==============================================================*/
create index DEFINI_FK on PLAQUE (
   TYPE_PLAQUE ASC
);

/*==============================================================*/
/* Table : PUIT                                                 */
/*==============================================================*/
create table PUIT 
(
   ID_PUIT              INTEGER              not null,
   ID_PLAQUE            INTEGER              not null,
   ID_N_UPLET           INTEGER              not null,
   QT_MAX               NUMBER               not null
      constraint CKC_QT_MAX_PUIT check (QT_MAX >= 0),
   X                    INTEGER              not null
      constraint CKC_X_PUIT check (X >= 0),
   Y                    INTEGER              not null
      constraint CKC_Y_PUIT check (Y >= 0),
   constraint PK_PUIT primary key (ID_PUIT)
);

/*==============================================================*/
/* Index : POSSEDE_FK                                           */
/*==============================================================*/
create index POSSEDE_FK on PUIT (
   ID_PLAQUE ASC
);

/*==============================================================*/
/* Index : FORME_FK                                             */
/*==============================================================*/
create index FORME_FK on PUIT (
   ID_N_UPLET ASC
);

/*==============================================================*/
/* Table : RESULTAT_N_UPLET                                     */
/*==============================================================*/
create table RESULTAT_N_UPLET 
(
   ID_RESULTAT_N_UPLET  INTEGER              not null,
   MOYR                 NUMBER               not null,
   MOYV                 NUMBER               not null,
   MOYB                 NUMBER               not null,
   MOYT                 NUMBER               not null,
   ECARTR               NUMBER               not null,
   ECARTV               NUMBER               not null,
   ECARTB               NUMBER               not null,
   ECARTT               NUMBER               not null,
   RESULTAT_N_UPLET     VARCHAR2(25)         not null
      constraint CKC_RESULTAT_N_UPLET_RESULTAT check (RESULTAT_N_UPLET in ('acceptee','refusee')),
   constraint PK_RESULTAT_N_UPLET primary key (ID_RESULTAT_N_UPLET)
);

/*==============================================================*/
/* Table : RESULTAT_PUIT                                        */
/*==============================================================*/
create table RESULTAT_PUIT 
(
   ID_RESULTAT_PUIT     INTEGER              not null,
   ID_PHOTOMETRE        INTEGER              not null,
   ID_RESULTAT_N_UPLET  INTEGER              not null,
   ID_PUIT              INTEGER              not null,
   NOM_FICHIER          CLOB                 not null,
   RM                   NUMBER               not null
      constraint CKC_RM_RESULTAT check (RM between 0 and 255),
   RD                   NUMBER               not null
      constraint CKC_RD_RESULTAT check (RD >= 0),
   VM                   NUMBER               not null
      constraint CKC_VM_RESULTAT check (VM between 0 and 255),
   VD                   NUMBER               not null
      constraint CKC_VD_RESULTAT check (VD >= 0),
   BM                   NUMBER               not null
      constraint CKC_BM_RESULTAT check (BM between 0 and 255),
   BD                   NUMBER               not null
      constraint CKC_BD_RESULTAT check (BD >= 0),
   TM                   NUMBER               not null
      constraint CKC_TM_RESULTAT check (TM between 0 and 255),
   TD                   NUMBER               not null
      constraint CKC_TD_RESULTAT check (TD >= 0),
   HORODATAGE           DATE                 not null,
   constraint PK_RESULTAT_PUIT primary key (ID_RESULTAT_PUIT)
);

/*==============================================================*/
/* Index : A_UN_FK                                              */
/*==============================================================*/
create index A_UN_FK on RESULTAT_PUIT (
   ID_PUIT ASC
);

/*==============================================================*/
/* Index : CALCULE_FK                                           */
/*==============================================================*/
create index CALCULE_FK on RESULTAT_PUIT (
   ID_RESULTAT_N_UPLET ASC
);

/*==============================================================*/
/* Index : CREE_FK                                              */
/*==============================================================*/
create index CREE_FK on RESULTAT_PUIT (
   ID_PHOTOMETRE ASC
);

/*==============================================================*/
/* Table : SOLUTION                                             */
/*==============================================================*/
create table SOLUTION 
(
   ID_SOLUTION          INTEGER              not null,
   ID_CELL_CANCEREUSE   INTEGER              not null,
   ID_AGENT_BIO         INTEGER              not null,
   constraint PK_SOLUTION primary key (ID_SOLUTION)
);

/*==============================================================*/
/* Index : COMPORTE_FK                                          */
/*==============================================================*/
create index COMPORTE_FK on SOLUTION (
   ID_AGENT_BIO ASC
);

/*==============================================================*/
/* Index : ASSOCIATION_5_FK                                     */
/*==============================================================*/
create index ASSOCIATION_5_FK on SOLUTION (
   ID_CELL_CANCEREUSE ASC
);

/*==============================================================*/
/* Table : TYPE_PLAQUE                                          */
/*==============================================================*/
create table TYPE_PLAQUE 
(
   TYPE_PLAQUE          VARCHAR2(25)         not null
      constraint CKC_TYPE_PLAQUE_TYPE_PLA check (TYPE_PLAQUE in ('96puits','384puits')),
   PRIX_PLAQUE          NUMBER               not null
      constraint CKC_PRIX_PLAQUE_TYPE_PLA check (PRIX_PLAQUE >= 0),
   constraint PK_TYPE_PLAQUE primary key (TYPE_PLAQUE)
);

alter table EXPERIENCE
   add constraint FK_EXPERIEN_CORRESPON_LIGNE_FA foreign key (ID_LIGNE)
      references LIGNE_FACTURE (ID_LIGNE);

alter table FACTURE
   add constraint FK_FACTURE_DOIT_PAYE_EQUIPE foreign key (ID_EQUIPE)
      references EQUIPE (ID_EQUIPE);

alter table FAIT
   add constraint FK_FAIT_FAIT_PERSONNE foreign key (ID_PERSONNE)
      references PERSONNE (ID_PERSONNE);

alter table FAIT
   add constraint FK_FAIT_FAIT2_EXPERIEN foreign key (ID_EXPERIENCE)
      references EXPERIENCE (ID_EXPERIENCE);

alter table HISTO_EXPERIENCE
   add constraint FK_HISTO_EX_A_FAIT_PERSONNE foreign key (ID_PERSONNE)
      references PERSONNE (ID_PERSONNE);

alter table HISTO_EXPERIENCE
   add constraint FK_HISTO_EX_HISTORISE_EXPERIEN foreign key (ID_EXPERIENCE)
      references EXPERIENCE (ID_EXPERIENCE);

alter table HISTO_PHOTOMETRE
   add constraint FK_HISTO_PH_A_MODIFIE_PERSONNE foreign key (ID_PERSONNE)
      references PERSONNE (ID_PERSONNE);

alter table HISTO_PHOTOMETRE
   add constraint FK_HISTO_PH_HISTORISE_PHOTOMET foreign key (ID_PHOTOMETRE)
      references PHOTOMETRE (ID_PHOTOMETRE);

alter table LIGNE_FACTURE
   add constraint FK_LIGNE_FA_CORRESPON_EXPERIEN foreign key (ID_EXPERIENCE)
      references EXPERIENCE (ID_EXPERIENCE);

alter table LIGNE_FACTURE
   add constraint FK_LIGNE_FA_EST_REMPL_FACTURE foreign key (ID_FACTURE)
      references FACTURE (ID_FACTURE);

alter table N_UPLET
   add constraint FK_N_UPLET_ACQUIERT_EXPERIEN foreign key (ID_EXPERIENCE)
      references EXPERIENCE (ID_EXPERIENCE);

alter table N_UPLET
   add constraint FK_N_UPLET_CONTIENT_RESULTAT foreign key (ID_RESULTAT_N_UPLET)
      references RESULTAT_N_UPLET (ID_RESULTAT_N_UPLET);

alter table N_UPLET
   add constraint FK_N_UPLET_RECOIT_SOLUTION foreign key (ID_SOLUTION)
      references SOLUTION (ID_SOLUTION);

alter table PERSONNE
   add constraint FK_PERSONNE_EST_DANS_EQUIPE foreign key (ID_EQUIPE)
      references EQUIPE (ID_EQUIPE);

alter table PLAQUE
   add constraint FK_PLAQUE_DEFINI_TYPE_PLA foreign key (TYPE_PLAQUE)
      references TYPE_PLAQUE (TYPE_PLAQUE);

alter table PUIT
   add constraint FK_PUIT_FORME_N_UPLET foreign key (ID_N_UPLET)
      references N_UPLET (ID_N_UPLET);

alter table PUIT
   add constraint FK_PUIT_POSSEDE_PLAQUE foreign key (ID_PLAQUE)
      references PLAQUE (ID_PLAQUE);

alter table RESULTAT_PUIT
   add constraint FK_RESULTAT_A_UN_PUIT foreign key (ID_PUIT)
      references PUIT (ID_PUIT);

alter table RESULTAT_PUIT
   add constraint FK_RESULTAT_CALCULE_RESULTAT foreign key (ID_RESULTAT_N_UPLET)
      references RESULTAT_N_UPLET (ID_RESULTAT_N_UPLET);

alter table RESULTAT_PUIT
   add constraint FK_RESULTAT_CREE_PHOTOMET foreign key (ID_PHOTOMETRE)
      references PHOTOMETRE (ID_PHOTOMETRE);

alter table SOLUTION
   add constraint FK_SOLUTION_ASSOCIATI_CELLULE foreign key (ID_CELL_CANCEREUSE)
      references CELLULE (ID_CELL_CANCEREUSE);

alter table SOLUTION
   add constraint FK_SOLUTION_COMPORTE_AGENT_BI foreign key (ID_AGENT_BIO)
      references AGENT_BIOLOGIQUE (ID_AGENT_BIO);
