package composer

import (
    "alpha.dagger.io/dagger"
    "alpha.dagger.io/os"
    "alpha.dagger.io/docker"
    // "alpha.dagger.io/dagger/op"
)

// A Composer package
#Package: {
    version: *"2" | string @dagger(input)

    // Application source code
    source: dagger.#Artifact @dagger(input)

	// Build output directory
	output: os.#Dir & {
        from: ctr
		path: "/app"
	} @dagger(output)

    ctr: os.#Container & {
        image: docker.#Pull & {
            from: "docker.io/composer:\(version)"
        }
        command: "composer install --ignore-platform-reqs --no-scripts"
        mount: "/app": from: source
        dir: "/app"
    }
}
