class CpuSentinel < Formula
	desc "CPU Sentinel CLI"
	homepage "https://github.com/lstarrett/cpu-sentinel"
	url "https://github.com/lstarrett/cpu-sentinel/archive/0.5.tar.gz"
	sha256 "7591c4ca41ee4c430de431fc46ab4284eed8ca4311081dd3b218d0c83b204432"
	license "MIT"
	version "0.5"

	# Create a config dir in /usr/local/etc for config files
	#   which will persist undisturbed across `brew upgrade`
	def configdir
		etc/"cpu-sentinel"
	end

	# Install binary and config file
	def install
		bin.install "cpu-sentinel"
		configdir.install "procs.conf"
	end

	# Define Apple Launchd service plist file
	#
	# This service runs CPU Sentinel every ten minutes to search for latest PIDs for
	# target processes and de-prioritize them to the minimum scheduler niceness
	# level on macOS (20).
	#
	# Homebrew Services and macOS Launchd docs::
	#   https://docs.brew.sh/Formula-Cookbook#launchd-plist-files
	#   https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html
	#
	def plist; <<~EOS
		<?xml version="1.0" encoding="UTF-8"?>
		<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
		<plist version="1.0">
			<dict>
			<key>Label</key>
			<string>com.cpusentinel</string>

			<key>ProgramArguments</key>
			<array>
				<string>/usr/local/opt/cpu-sentinel/bin/cpu-sentinel</string>
				<string>-f</string>
				<string>/usr/local/etc/cpu-sentinel/procs.conf</string>
				<string>-s</string>
				<string>0</string>
				<string>-p</string>
				<string>20</string>
			</array>

			<key>StartInterval</key>
			<integer>600</integer>

			<key>StandardErrorPath</key>
			<string>/usr/local/var/log/homebrew.mxcl.cpu-sentinel.err</string>

			<key>StandardOutPath</key>
			<string>/usr/local/var/log/homebrew.mxcl.cpu-sentinel.log</string>

			<key>RunAtLoad</key>
			<true/>
			</dict>
		</plist>
		EOS
	end

	test do
	# assert that the version of the CPU Sentinel is correct, and it exits with 0 exit code
	assert_match "CPU Sentinel v0.3 alpha", shell_output("#{bin}/cpu-sentinel --version", 0)
	end
end
