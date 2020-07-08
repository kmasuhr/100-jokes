import {HttpModule, Module} from '@nestjs/common';
import {AppController} from './app.controller';
import {BashOrgService} from "./servieces/bash-org.service";

@Module({
    imports: [HttpModule],
    controllers: [AppController],
    providers: [BashOrgService],
})
export class AppModule {
}
