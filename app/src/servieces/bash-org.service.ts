import {HttpService, Injectable} from '@nestjs/common';
import {forkJoin, Observable} from 'rxjs';
import {parse} from 'node-html-parser';
import {map} from 'rxjs/operators';
import {AxiosResponse} from "axios";

@Injectable()
export class BashOrgService {
    private static readonly JOKES_PER_PAGE = 20;
    private static readonly BASE_URL = 'http://bash.org.pl/latest/';

    constructor(private httpService: HttpService) {
    }

    private static parseJokes(rawHtml: string) {
        const page = parse(rawHtml);
        return page.querySelectorAll('.post-body')
            .map(html => html.text.replace(/(\r\n|\n|\r|\t)/gm, ''))
    }

    getJokes(numberOfJokes = 10): Observable<string[]> {
        const numberOfPages = Math.ceil(numberOfJokes / BashOrgService.JOKES_PER_PAGE);

        return forkJoin(this.getListOfObservables(numberOfPages)).pipe(
            map((responses: AxiosResponse[]) => responses.map(response => BashOrgService.parseJokes(response.data))),
            map((responses: Array<Array<string>>) => this.mergeAllPages(responses, numberOfJokes))
        )
    }

    private getListOfObservables(numberOfPages: number): Observable<AxiosResponse>[] {
        const allRequests = []

        Array.from({length: numberOfPages}, (x, index) => {
            const url = `${BashOrgService.BASE_URL}?page=${index + 1}`
            allRequests.push(this.httpService.get(url))
        });

        return allRequests
    }

    private mergeAllPages(responses: Array<Array<string>>, numberOfJokes: number): string[] {
        let allJokes = []

        responses.forEach(jokeSet => {
            allJokes = [...allJokes, ...jokeSet]
        })

        return allJokes.length > numberOfJokes ? allJokes.slice(0, numberOfJokes) : allJokes;
    }
}