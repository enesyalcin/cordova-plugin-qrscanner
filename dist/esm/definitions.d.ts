declare global {
    interface PluginRegistry {
        QRScanner?: QRScannerPlugin;
    }
}
export interface QRScannerPlugin {
    echo(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
}
