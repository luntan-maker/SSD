
package SSDPackage {
    doc
    /*This package defines the usage and structure of an SSD*/
    item def StorageDevice;
    item def Computer;

    use case def 'Write to SSD' {
        subject ssd : StorageDevice{
            event occurrence workstationWritesFile[1];
            then event occurrence ssdWritesFile[1];
        };
        actor Workstation : Computer{
            event occurrence workstationWritesFile[1];
        }
        objective {
            doc 
            /*Basic saving of a file to an SSD*/
        }
    }
    use case def 'Read from SSD' {
        subject ssd : StorageDevice{
            event occurrence workstationReadsFile[1];
            then event occurrence ssdReadsFile[1];
        };
        actor Workstation : Computer{
            event occurrence workstationReadsFile[1];
        }
        objective {
            doc 
            /*Basic reading of a file from an SSD*/
        }

    }

    part def ElectronicComponent;
    connection def Trace {
        end [1] part fromComponent : ElectronicComponent;
        end [1] part toComponent : ElectronicComponent;
    }
    part SSD{
        part NANDFlashMemoryController{
            part HardwareInterfaceLayer;
            part FlashTranslationLayer;
        };
        part NANDMemory{
            attribute memory;

        };
        connection controller2memory[*] : Trace 
            connect NANDFlashMemoryController to NANDMemory;
    }


}


// So the whole ssd is controlled by the nand flash controller
// https://www.delkin.com/blog/understanding-nand-flash-based-ssd-drives-and-the-flash-controller/
// Nand flash controller is essentially a cpu with some bells and whistles
// https://github.com/Lemme-lab/Verilog-Simple-CPU/tree/main
// How hard would it be to make my own version of the nand flash controller?
// file:///home/luke/Downloads/NAND_Flash_Interface_AN.pdf

// The good stuff
// https://github.com/GfSE/SysML-v2-Models/tree/main
// Outlines for what I need to do
// https://www.omg.org/spec/SysML/1.2/PDF
// Reference
// https://sim4edu.com/reading/kerml-sysml#IntroDynamicsSysML
// https://learnxinyminutes.com/yaml/