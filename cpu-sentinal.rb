class CpuSentinel < Formula
	desc "CPU Sentinel CLI"
	homepage "https://github.com/lstarrett/cpu-sentinel"
	url "https://github.com/lstarrett/cpu-sentinel/archive/0.1.tar.gz"
	sha256 "c81aeb0c0ecf39208c3cf1c8a1eb4be90430b099423193c29577acf8299e4e12"
	license "MIT"
	version "0.1"

	def install
	# Move everything under #{libexec}/
	libexec.install Dir["*"]

	# Then write executables under #{bin}/
	bin.write_exec_script (libexec/"cpu-sentinel")
	end

	# https://docs.brew.sh/Formula-Cookbook#launchd-plist-files
	# https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html
	def plist; <<-EOS.undent
	<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
	<plist version="1.0">
		<dict>
		<key>Label</key>
		<string>com.cpusentinel</string>

		<key>ProgramArguments</key>
		<array>
			<string>cpu-sentinel</string>
			<string>-f</string>
			<string>process_list</string>
			<string>-s</string>
			<string>0</string>
			<string>-p</string>
			<string>20</string>
		</array>

		<key>StartInterval</key>
		<integer>120</integer>

		<key>StandardErrorPath</key>
		<string>err</string>

		<key>StandardOutPath</key>
		<string>log</string>

		<key>RunAtLoad</key>
		<true/>
		</dict>
	</plist>
	EOS
	end

	test do
	system "true"
	# assert_match "mytool version 1.0.0", shell_output("#{bin}/mytool -v", 2)
	end
end
