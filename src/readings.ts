export class Readings {
    VOC?: number
    Temperature?: number
    Humidity?: number
    Pressure?: number
    toArray(): {type: string, value: string | undefined }[]{
        return [{type: 'Летливи органични съединения', value: `${this.VOC! * 100} %`}, {type:'Температура' , value: `${this.Temperature}°C`}, {type: 'Влажност', value:`${this.Humidity! * 100} %`}, {type: 'Атмосферно налягане',value: `${this.Pressure} hPa`}] as {type: string, value: string | undefined}[]
    }

    constructor({ VOC, Temperature, Humidity, Pressure }: { VOC?: number, Temperature?: number, Humidity?: number, Pressure?: number}){
        this.VOC = VOC
        this.Temperature = Temperature
        this.Humidity = Humidity
        this.Pressure = Pressure
    }
}