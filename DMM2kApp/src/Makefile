TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC support library

LIBRARY_IOC += DMM2kSupport

# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord
# Install devXxxSoft.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Compile and add the code to the support library
DMM2kSupport_SRCS += xxxRecord.c
DMM2kSupport_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application.
DMM2kSupport_SRCS += dbSubExample.c
DMM2kSupport_SRCS += DMM2kHello.c
DMM2kSupport_SRCS += initTrace.c

DMM2kSupport_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================
# Build the IOC application

PROD_IOC = DMM2k
# DMM2k.dbd will be created and installed
DBD += DMM2k.dbd

# DMM2k.dbd will be made up from these files:
DMM2k_DBD += base.dbd
DMM2k_DBD += xxxSupport.dbd
DMM2k_DBD += dbSubExample.dbd
DMM2k_DBD += DMM2kHello.dbd
DMM2k_DBD += initTrace.dbd
DMM2k_DBD += system.dbd
DMM2k_DBD += Keithley3706A.dbd

DMM2k_DBD += asyn.dbd
DMM2k_DBD += drvAsynSerialPort.dbd 
DMM2k_DBD += drvAsynIPPort.dbd 
DMM2k_DBD += devEpics.dbd 
DMM2k_DBD += devGpib.dbd 
DMM2k_DBD += ipSupport.dbd
DMM2k_DBD += calcSupport.dbd
#DMM2k_DBD += sseqRecord.dbd
DMM2k_DBD += stream.dbd

# DMM2k_registerRecordDeviceDriver.cpp derives from DMM2k.dbd
DMM2k_SRCS += DMM2k_registerRecordDeviceDriver.cpp
#DMM2k_SRCS += sseqRecord.c

DMM2k_SRCS += Keithley3706A.st

# Build the main IOC entry point on workstation OSs.
DMM2k_SRCS_DEFAULT += DMM2kMain.cpp
DMM2k_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#DMM2k_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Link in the code from the support library
DMM2k_LIBS += DMM2kSupport
DMM2k_LIBS += ip
DMM2k_LIBS += asyn
DMM2k_LIBS += seq pv calc
DMM2k_LIBS += stream

# NOTE: To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file

ifneq ($(SNCSEQ),)
    # Build sncExample into DMM2kSupport
    sncExample_SNCFLAGS += +r
    DMM2k_DBD += sncExample.dbd
    DMM2kSupport_SRCS += sncExample.stt
    DMM2kSupport_LIBS += seq pv
    DMM2k_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)

    # Build sncProgram as a standalone program
#    PROD_HOST += Keithley3706A
#    Keithley3706A_SNCFLAGS += +m
#    Keithley3706A_SRCS += Keithley3706A.st
#    Keithley3706A_LIBS += seq pv
#    Keithley3706A_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Finally link to the EPICS Base libraries
DMM2k_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

