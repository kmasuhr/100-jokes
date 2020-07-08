import {Controller, Get} from '@nestjs/common';
import {BashOrgService} from "./servieces/bash-org.service";
import {Observable} from "rxjs";

@Controller()
export class AppController {
    constructor(private readonly bashOrgService: BashOrgService) {
    }

    @Get()
    getHello(): Observable<string[]> {
        return this.bashOrgService.getJokes(100);
    }
}
