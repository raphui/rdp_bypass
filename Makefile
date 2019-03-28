TARGET_NAME := rdp_bypass

MCPU=cortex-m4

INCLUDES :=

CFLAGS :=  -Wall -fno-builtin -ffunction-sections -fomit-frame-pointer
CFLAGS += -mcpu=$(MCPU) -mthumb -nostdlib $(INCLUDES)
CFLAGS +=  -fno-common
#CFLAGS += -msingle-pic-base -fno-inline -fPIE -mlong-calls


LDFLAGS	:= -g $(INCLUDES) -nostartfiles -nostdlib #-Wl,--gc-sections

LD_SCRIPT = stm32.ld

CC := $(CROSS_COMPILE)gcc
AS := $(CROSS_COMPILE)as
AR := $(CROSS_COMPILE)ar
LD := $(CROSS_COMPILE)gcc
OBJCOPY := $(CROSS_COMPILE)objcopy

OBJS := rdp_bypass.o

all: $(TARGET_NAME)

clean:
	$(RM) $(TARGET_NAME)
	$(RM) $(OBJS)

$(TARGET_NAME): $(OBJS) 
	@@echo "LD " $@
	@$(LD) -o $@ $^ $(LDFLAGS) -T$(LD_SCRIPT)
	@$(OBJCOPY) $@ -O binary $@.bin

%.o: %.c
	@@echo "CC " $<
	@$(CC) $(CFLAGS) -c $< -o $@

%.o: %.S
	@@echo "CC " $<
	@$(CC) $(CFLAGS) -c $< -o $@
