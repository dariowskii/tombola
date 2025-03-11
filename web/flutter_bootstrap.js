{{flutter_js}}
{{flutter_build_config}}

const loading = document.createElement('div');

loading.style.width = '100svw';
loading.style.height = '100svh';
loading.style.margin = '0';
loading.style.padding = '0';
loading.style.display = 'flex';
loading.style.justifyContent = 'center';
loading.style.alignItems = 'center';

loading.innerHTML = `
    <style>
        .loader {
            border: 1rem solid #f3f3f3;
            border-top: 1rem solid #20406A;
            border-radius: 50%;
            width: 8rem;
            height: 8rem;
            animation: spin 2s ease-out infinite;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
    <div class="loader"></div>
`;
document.body.appendChild(loading);

_flutter.buildConfig.builds[0].mainJsPath += "?v=" + serviceWorkerVersion;

_flutter.loader.load({
    serviceWorkerSettings: {
        serviceWorkerVersion: serviceWorkerVersion
    },
    onEntrypointLoaded: async function(engineInitializer) {
        const appRunner = await engineInitializer.initializeEngine();
        await appRunner.runApp();
        document.body.removeChild(loading);
    },
});