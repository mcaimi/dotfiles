#!/usr/bin/env python3
#
# PulseAudio Controller for i3-gaps
#

from subprocess import check_output, CalledProcessError
import sys
import argparse

class PulseController(object):
    def __init__(self):
        self.padump_awk = "pacmd dump | awk '/%s/ {print $2}'"
        self.pamute_awk = "pacmd dump | awk '/set-sink-mute %s/ {print $3}'"
        self.pactl_set_volume = "pactl set-sink-volume %s %s"
        self.default_sink = self.get_default_sink()
        self.default_source = self.get_default_source()

    def _cmdrun(self, commandline):
        try:
            return check_output(commandline, shell=True)
        except CalledProcessError as ex:
            return ex.returncode

    def pulse_channel(self, command, pacmd):
        val = self._cmdrun(command % pacmd)
        if (isinstance(val, bytes)):
            val = val.strip().decode(encoding='UTF-8')
        return val

    def get_default_sink(self):
        return self.pulse_channel(self.padump_awk, "set-default-sink")

    def get_default_source(self):
        return self.pulse_channel(self.padump_awk, "set-default-source")

    def _toggle_sink_mute(self, sink, state):
        mstate = self.pulse_channel("pacmd %s %s %s", ("set-sink-mute", sink, state))
        return mstate

    def toggle_default_sink_mute_state(self):
        is_mute = self.pulse_channel(self.pamute_awk, self.default_sink)
        if isinstance(is_mute, bytes):
            is_mute = is_mute.strip().decode(encoding='UTF-8')

        # check sink state
        if is_mute == "no":
            self._toggle_sink_mute(self.default_sink, "yes")
        else:
            self._toggle_sink_mute(self.default_sink, "no")

    def _set_volume(self, sink, amount):
        return self.pulse_channel(self.pactl_set_volume, (sink, amount))

    def raise_volume(self, amount):
        if not isinstance(amount, str):
            amount = str(amount)

        vparm = "+%s%s" % (amount, '%')
        print(vparm)
        self._set_volume(self.default_sink, vparm)

    def lower_volume(self, amount):
        if not isinstance(amount, str):
            amount = str(amount)

        vparm = "-%s%s" % (amount, '%')
        self._set_volume(self.default_sink, vparm)

if __name__ == '__main__':
    # create an instance of the pulse controller
    pController = PulseController()

    aParser = argparse.ArgumentParser()
    aParser.add_argument('-m', '--mute', action='store_true')
    aParser.add_argument('-r', '--vraise')
    aParser.add_argument('-l', '--vlower')

    options = aParser.parse_args(sys.argv[1:])
    print(options)

    if options.mute == True:
        pController.toggle_default_sink_mute_state()
    else:
        if options.vraise is not None:
            pController.raise_volume(options.vraise)
            sys.exit(0)
        elif options.vlower is not None:
            pController.lower_volume(options.vlower)
            sys.exit(0)


