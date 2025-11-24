import { BleClient } from '@capacitor-community/bluetooth-le';

const SERVICE_UUID = "7d8b5ccd-ff95-4228-80fa-e7c51e09b54b"


export async function scan(): Promise<void> {
    try {
        await BleClient.initialize();

        await BleClient.requestLEScan(
            {
                services: [SERVICE_UUID],
            },
            (result) => {
                console.log('received new scan result', result);
            },
        );

        setTimeout(async () => {
            await BleClient.stopLEScan();
            console.log('stopped scanning');
        }, 5000);
    } catch (error) {
        console.error(error);
    }
}