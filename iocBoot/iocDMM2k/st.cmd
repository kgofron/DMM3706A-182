#!../../bin/linux-x86_64/DMM2k

## You may have to change DMM2k to something else
## everywhere it appears in this file

< envPaths

epicsEnvSet("ENGINEER",  "kgofron x5283")
epicsEnvSet("LOCATION",  "740 IXS RG:D1")
#epicsEnvSet("STREAM_PROTOCOL_PATH", ".:../protocols:$(PMACUTIL)/protocol")
epicsEnvSet("KP_PORT",   "DMM3706A")
epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST", "NO")
epicsEnvSet("EPICS_CA_ADDR_LIST", "10.10.0.255")

epicsEnvSet("P",         "XF:10IDB-BI")
epicsEnvSet("R",         "{DMM:1-K3706A}")
# epicsEnvSet("IOCNAME",   "k3706")

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/DMM2k.dbd"
DMM2k_registerRecordDeviceDriver pdbbase

############ Asyn Communication Config ############
# cfg comms for Keithley 3706A controllers
#drvAsynIPPortConfigure("tsrv2-P3","10.10.2.54:4003")
#drvAsynIPPortConfigure("tsrv2-P4","10.10.2.54:4004")
#drvAsynIPPortConfigure("$(KP_PORT)","10.10.2.182:5025")
drvAsynIPPortConfigure("$(KP_PORT)","10.10.2.183:5025")

## Load record instances
#dbLoadTemplate "db/userHost.substitutions"
#dbLoadRecords "db/dbSubExample.db", "user=kgofronHost"

# Keithley 3706A DMM
#dbLoadRecords("$(IP)/ipApp/Db/Keithley2kDMM_mf.db","P=xxx:,Dmm=D1,PORT=serial1")
#dbLoadRecords("/usr/lib/epics/db/Keithley2kDMM_mf.db","P=$(P),Dmm=$(R),PORT=tsrv2-P3")
#dbLoadRecords("/usr/lib/epics/db/Keithley2kDMM_mf.db","P=$(P),Dmm=$(R),PORT=tsrv2-P4")
#dbLoadRecords("/usr/lib/epics/db/Keithley2kDMM_mf.db","P=$(P),Dmm=$(R),PORT=$(KP_PORT)")
#dbLoadRecords("db/Keithley3706DMM_mf.db","P=$(P),Dmm=$(R),PORT=$(KP_PORT)")
dbLoadTemplate("db/Keithley3706A.substitutions")

### Load asynRecords for general comms to each PORT
#dbLoadRecords("db/asyn.db")

### devIocStats
#dbLoadRecords("${EPICS_BASE}/db/iocAdminSoft.db", "IOC=XF:10IDB-CT{DMM:1}")
###################################################

# asyn debug traces
asynSetTraceMask("$(KP_PORT)",-1,0x9)
asynSetTraceIOMask("$(KP_PORT)",-1,0x2)

## Set this to see messages from mySub
#var mySubDebug 1

## Run this to trace the stages of iocInit
#traceIocInit

cd ${TOP}/iocBoot/${IOC}
iocInit

## Start any sequence programs
#seq sncExample, "user=kgofronHost"

#seq &Keithley2kDMM, "P=13Keithley1:, Dmm=DMM1, channels=22, model=2700, stack=10000"
#doAfterIocInit()
#seq &Keithley2kDMM, "P=$(P), Dmm=$(R), channels=20, model=3706A"
seq Keithley3706A, "P=$(P), Dmm=$(R), channels=60, model=3706A"
#seq sncExample, "P=$(P), Dmm=$(R), channels=20, model=3706A"

cd ${TOP}
dbl > ./records.dbl
#system "cp ./records.dbl /cf-update/$HOSTNAME.$IOCNAME.dbl"
