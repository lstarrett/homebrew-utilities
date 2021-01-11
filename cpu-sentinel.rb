class CpuSentinel < Formula
	desc "CPU Sentinel CLI"
	homepage "https://github.com/lstarrett/cpu-sentinel"
	url "https://github.com/lstarrett/cpu-sentinel/archive/v1.0.tar.gz"
	sha256 "f81cc29ce25cbd49d2f184450e358f6ba9cce7f7bdbaf4c5b71baf099a1a128b"
	license "MIT"
	version "1.0"

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
	assert_match "CPU Sentinel v1.0", shell_output("#{bin}/cpu-sentinel --version", 0)
	end
end
